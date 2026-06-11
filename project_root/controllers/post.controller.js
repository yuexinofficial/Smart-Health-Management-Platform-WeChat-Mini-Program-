const pool = require('../config/db');

// 生成本地时间字符串 (UTC+8)
function localTime() {
  const d = new Date();
  const pad = n => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}`;
}

module.exports = {

    // 创建帖子
    async createPost(req, res) {
        try {
            const { topic, content, image_path, phone } = req.body;
            if (!topic || !content || !phone) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            const [result] = await pool.query(
                'INSERT INTO community SET ?',
                {
                    phone,
                    post_topic: topic,
                    content,
                    image_path,
                    post_time: localTime()
                }
            );

            res.json({
                success: true,
                postId: result.insertId,
                message: '帖子创建成功'
            });
        } catch (err) {
            console.error('[创建帖子错误]', err);
            res.status(500).json({ code: 'POST_CREATE_FAILED', message: '帖子创建失败' });
        }
    },

    // 获取帖子列表
    async getPosts(req, res) {
        try {
            const { searchQuery, page = 1, pageSize = 10 } = req.body;
            const offset = (page - 1) * pageSize;

            let whereClause = '1=1';
            const queryParams = [];

            if (searchQuery) {
                whereClause += ' AND (post_topic LIKE ? OR content LIKE ?)';
                queryParams.push(`%${searchQuery}%`, `%${searchQuery}%`);
            }

            queryParams.push(offset, parseInt(pageSize));

            const [results] = await pool.query(
                `
                SELECT 
                    c.post_id,
                    c.post_topic,
                    c.content,
                    DATE_FORMAT(c.post_time, '%Y-%m-%d %H:%i') AS formatted_time, 
                    c.comment_count,
                    c.like_count,
                    u.nickname AS author
                FROM 
                    community c
                INNER JOIN 
                    users u ON c.phone = u.phone
                WHERE 
                    ${whereClause}
                ORDER BY 
                    c.post_time DESC
                LIMIT ?, ?
                `,
                queryParams
            );

            res.json({ success: true, posts: results });
        } catch (err) {
            console.error('[获取帖子列表错误]', err);
            res.status(500).json({ code: 'POST_LIST_FAILED', message: '获取帖子列表失败' });
        }
    },

    // 删除帖子
    async deletePost(req, res) {
        try {
            const { post_id } = req.body;

            if (!post_id) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段: post_id' });
            }

            // 删除与帖子相关的评论
            await pool.query('DELETE FROM comments WHERE post_id = ?', [post_id]);

            // 删除与帖子相关的点赞记录
            await pool.query('DELETE FROM post_likes WHERE post_id = ?', [post_id]);

            // 删除帖子
            const [result] = await pool.query('DELETE FROM community WHERE post_id = ?', [post_id]);

            if (result.affectedRows === 0) {
                return res.status(404).json({ code: 'POST_NOT_FOUND', message: '帖子不存在' });
            }

            res.json({ success: true, message: '帖子删除成功' });
        } catch (err) {
            console.error('[删除帖子错误]', err);
            res.status(500).json({ code: 'POST_DELETE_FAILED', message: '帖子删除失败' });
        }
    },

    async getPostDetail(req, res) {
        try {
            const { postId, phone } = req.body;

            const [results] = await pool.query(
                `
                SELECT 
                    c.*, 
                    u.nickname AS author, 
                    COALESCE(u.avatar_url, '/images/avatar.png') AS avatar_url,
                    EXISTS(SELECT 1 FROM post_likes WHERE post_id = c.post_id AND phone = ?) AS is_liked
                FROM community c
                JOIN users u ON c.phone = u.phone
                WHERE c.post_id = ?
                `,
                [phone, postId]
            );

            if (results.length === 0) {
                return res.status(404).json({ code: 'POST_NOT_FOUND', message: '帖子不存在' });
            }

            const post = results[0];
            res.json({
                success: true,
                post: {
                    ...post,
                    is_liked: Boolean(post.is_liked),
                    like_count: post.like_count || 0,
                    comment_count: post.comment_count || 0
                }
            });
        } catch (err) {
            console.error('[获取帖子详情错误]', err);
            res.status(500).json({ code: 'POST_DETAIL_FAILED', message: '获取帖子详情失败' });
        }
    },

    async createComment(req, res) {
        try {
            const { postId, phone, content } = req.body;

            const [result] = await pool.query(
                'INSERT INTO comments (phone, post_id, comment_content, comment_time) VALUES (?, ?, ?, ?)',
                [phone, postId, content, localTime()]
            );

            await pool.query(
                'UPDATE community SET comment_count = comment_count + 1 WHERE post_id = ?',
                [postId]
            );

            res.json({ success: true, commentId: result.insertId, message: '评论创建成功' });
        } catch (err) {
            console.error('[创建评论错误]', err);
            res.status(500).json({ code: 'COMMENT_CREATE_FAILED', message: '评论创建失败' });
        }
    },

    async deleteComment(req, res) {
        try {
            const { commentId } = req.body;

            const [comment] = await pool.query(
                'SELECT post_id FROM comments WHERE comment_id = ?',
                [commentId]
            );

            if (comment.length === 0) {
                return res.status(404).json({ code: 'COMMENT_NOT_FOUND', message: '评论不存在' });
            }

            const postId = comment[0].post_id;

            await pool.query('DELETE FROM comments WHERE comment_id = ?', [commentId]);
            await pool.query(
                'UPDATE community SET comment_count = comment_count - 1 WHERE post_id = ?',
                [postId]
            );

            res.json({ success: true, message: '评论删除成功' });
        } catch (err) {
            console.error('[删除评论错误]', err);
            res.status(500).json({ code: 'COMMENT_DELETE_FAILED', message: '评论删除失败' });
        }
    },

    async toggleLike(req, res) {
        try {
            const { postId, phone, isLike } = req.body;

            const operation = isLike ? 1 : -1;

            await pool.query(
                'UPDATE community SET like_count = GREATEST(like_count + ?, 0) WHERE post_id = ?',
                [operation, postId]
            );

            if (isLike) {
                await pool.query(
                    'INSERT INTO post_likes (post_id, phone) VALUES (?, ?)',
                    [postId, phone]
                );
            } else {
                await pool.query(
                    'DELETE FROM post_likes WHERE post_id = ? AND phone = ?',
                    [postId, phone]
                );
            }

            res.json({ success: true, newStatus: isLike });
        } catch (err) {
            console.error('[点赞操作错误]', err);
            res.status(500).json({ code: 'LIKE_TOGGLE_FAILED', message: '点赞操作失败' });
        }
    },
    // 获取用户帖子列表
    async getMyPosts(req, res) {
        try {
            const { phone, page = 1, pageSize = 10 } = req.body;
            const offset = (page - 1) * pageSize;

            const [results] = await pool.query(
                `
                SELECT 
                    c.post_id,
                    c.post_topic,
                    c.content,
                    DATE_FORMAT(c.post_time, '%Y-%m-%d %H:%i') AS formatted_time, 
                    c.comment_count,
                    c.like_count,
                    u.nickname AS author
                FROM 
                    community c
                INNER JOIN 
                    users u ON c.phone = u.phone
                WHERE 
                    c.phone = ?
                ORDER BY 
                    c.post_time DESC
                LIMIT ?, ?
                `,
                [phone, offset, parseInt(pageSize)]
            );

            res.status(200).json({ success: true, posts: results });
        } catch (err) {
            console.error('[获取用户帖子列表错误]', err);
            res.status(500).json({ code: 'GET_MY_POSTS_FAILED', message: '获取用户帖子列表失败' });
        }
    },

    // 获取评论列表
    async getComments(req, res) {
        try {
            const { postId } = req.body;

            if (!postId) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段: postId' });
            }

            const [results] = await pool.query(
                `
                SELECT 
                    c.*,
                    u.nickname,
                    u.avatar_url
                FROM 
                    comments c
                JOIN 
                    users u ON c.phone = u.phone
                WHERE 
                    c.post_id = ?
                ORDER BY 
                    c.comment_time DESC
                `,
                [postId]
            );

            res.status(200).json({ success: true, comments: results });
        } catch (err) {
            console.error('[获取评论列表错误]', err);
            res.status(500).json({ code: 'GET_COMMENTS_FAILED', message: '获取评论列表失败' });
        }
    },
};