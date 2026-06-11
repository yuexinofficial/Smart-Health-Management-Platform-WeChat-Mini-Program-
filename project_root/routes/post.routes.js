const router = require('express').Router();
const postController = require('../controllers/post.controller');

// 帖子操作
router.post('/create', postController.createPost);
router.post('/list', postController.getPosts);
router.post('/delete', postController.deletePost);
router.post('/detail', postController.getPostDetail);
router.post('/getMyPosts', postController.getMyPosts); // 添加获取用户帖子列表的路由

// 评论操作
router.post('/comment/create', postController.createComment);
router.post('/comment/delete', postController.deleteComment);
router.post('/comment/list', postController.getComments); // 添加获取评论列表的路由

// 点赞操作
router.post('/like/toggle', postController.toggleLike);

module.exports = router;