const pool = require('../config/db');
const bcrypt = require('bcrypt');
const axios = require('axios');

module.exports = {

    // 注册
    async register(req, res) {
        try {
            const { phone, password } = req.body;

            // 检查手机号是否存在
            const [existing] = await pool.query(
                'SELECT phone FROM users WHERE phone = ?',
                [phone]
            );

            if (existing.length > 0) {
                return res.status(400).json({ code: 'PHONE_EXISTS', message: '手机号已注册' });
            }

            // 密码加密
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(password, salt);

            // 创建用户
            await pool.query(
                'INSERT INTO users (phone, password) VALUES (?, ?)',
                [phone, hashedPassword]
            );

            res.json({ success: true, message: '注册成功' });
        } catch (err) {
            console.error('[注册错误]', err);
            res.status(500).json({ code: 'REGISTER_FAILED', message: '注册失败' });
        }
    },

    // 登录

    async login(req, res) {
        try {
            const { phone, password } = req.body;

            // 查询用户
            const [users] = await pool.query(
                'SELECT * FROM users WHERE phone = ?',
                [phone]
            );

            if (users.length === 0) {
                return res.status(400).json({ code: 'USER_NOT_FOUND', message: '用户不存在' });
            }

            // 验证密码
            const valid = await bcrypt.compare(password, users[0].password);
            if (!valid) {
                return res.status(400).json({ code: 'INVALID_PASSWORD', message: '密码错误' });
            }

            res.json({ success: true, message: '登录成功' });
        } catch (err) {
            console.error('[登录错误]', err);
            res.status(500).json({ code: 'LOGIN_FAILED', message: '登录失败' });
        }
    },

    // 更新密码

    async updatePassword(req, res) {
        try {
            const { phone, oldPassword, newPassword } = req.body;

            // 查询用户
            const [users] = await pool.query(
                'SELECT * FROM users WHERE phone = ?',
                [phone]
            );

            if (users.length === 0) {
                return res.status(400).json({ code: 'USER_NOT_FOUND', message: '用户不存在' });
            }

            // 验证旧密码
            const valid = await bcrypt.compare(oldPassword, users[0].password);
            if (!valid) {
                return res.status(400).json({ code: 'INVALID_OLD_PASSWORD', message: '旧密码错误' });
            }

            // 加密新密码
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(newPassword, salt);

            // 更新密码
            await pool.query(
                'UPDATE users SET password = ? WHERE phone = ?',
                [hashedPassword, phone]
            );

            res.json({ success: true, message: '密码更新成功' });
        } catch (err) {
            console.error('[更新密码错误]', err);
            res.status(500).json({ code: 'UPDATE_PASSWORD_FAILED', message: '密码更新失败' });
        }
    },

    // 重置密码

    async resetPassword(req, res) {
        try {
            const { phone, code, newPassword } = req.body;

            // 验证验证码
            if (!global.verificationCodes || global.verificationCodes[phone] !== parseInt(code, 10)) {
                return res.status(400).json({ code: 'INVALID_CODE', message: '验证码错误或已过期' });
            }

            // 加密新密码
            const salt = await bcrypt.genSalt(10);
            const hashedPassword = await bcrypt.hash(newPassword, salt);

            // 更新密码
            const [result] = await pool.query(
                'UPDATE users SET password = ? WHERE phone = ?',
                [hashedPassword, phone]
            );

            if (result.affectedRows === 0) {
                return res.status(400).json({ code: 'USER_NOT_FOUND', message: '用户不存在' });
            }

            res.json({ success: true, message: '密码重置成功' });
        } catch (err) {
            console.error('[重置密码错误]', err);
            res.status(500).json({ code: 'RESET_PASSWORD_FAILED', message: '密码重置失败' });
        }
    },

    // 更新用户信息

    async updateUser(req, res) {
        try {
            const { phone, nickname, height, gender, avatarUrl } = req.body;

            // 校验参数
            if (!phone || !nickname || !gender || !height) {
                return res.status(400).json({ code: 'INVALID_PARAMS', message: '参数不完整' });
            }

            // 更新用户信息
            const [result] = await pool.query(
                `UPDATE users SET 
                nickname = ?, 
                height = ?, 
                gender = ?, 
                avatar_url = ? 
                WHERE phone = ?`,
                [nickname, height, gender, avatarUrl || '/images/avatar.png', phone]
            );

            if (result.affectedRows === 0) {
                return res.status(404).json({ code: 'USER_NOT_FOUND', message: '用户不存在' });
            }

            res.json({ success: true, message: '用户信息更新成功' });
        } catch (err) {
            console.error('[更新用户信息错误]', err);
            res.status(500).json({ code: 'UPDATE_USER_FAILED', message: '用户信息更新失败' });
        }
    },

    // 获取用户信息
    async getUserInfo(req, res) {
        try {
            const { phone } = req.body;

            // 查询用户信息
            const [users] = await pool.query(
                'SELECT phone, nickname, gender, height, avatar_url FROM users WHERE phone = ?',
                [phone]
            );

            if (users.length === 0) {
                return res.status(404).json({ code: 'USER_NOT_FOUND', message: '用户不存在' });
            }

            res.json({ success: true, userInfo: users[0] });
        } catch (err) {
            console.error('[获取用户信息错误]', err);
            res.status(500).json({ code: 'GET_USER_INFO_FAILED', message: '获取用户信息失败' });
        }
    },
    // 上传头像
    async uploadAvatar(req, res) {
        try {
            if (!req.file) {
                return res.status(400).json({ success: false, message: '请选择图片文件' });
            }

            const { phone } = req.body;
            if (!phone) {
                return res.status(400).json({ success: false, message: '缺少用户信息' });
            }

            // 构建头像URL
            const avatarUrl = `/uploads/${req.file.filename}`;

            // 更新用户头像
            await pool.query(
                'UPDATE users SET avatar_url = ? WHERE phone = ?',
                [avatarUrl, phone]
            );

            res.json({ success: true, avatarUrl, message: '头像上传成功' });
        } catch (err) {
            console.error('[上传头像错误]', err);
            res.status(500).json({ success: false, message: '头像上传失败' });
        }
    },

    // 微信快捷登录（自动注册）
    async wechatLogin(req, res) {
        try {
            const { code, nickName, avatarUrl } = req.body;

            if (!code) {
                return res.status(400).json({ success: false, message: '缺少登录凭证' });
            }

            // 1. 用 code 换取 openid 和 session_key
            const appid = process.env.WX_APPID;
            const secret = process.env.WX_SECRET;

            const wxRes = await axios.get(
                `https://api.weixin.qq.com/sns/jscode2session`,
                { params: { appid, secret, js_code: code, grant_type: 'authorization_code' } }
            );

            if (wxRes.data.errcode) {
                console.error('[微信登录失败]', wxRes.data);
                return res.status(400).json({ success: false, message: '微信登录失败: ' + wxRes.data.errmsg });
            }

            const { openid, session_key } = wxRes.data;

            // 2. 查找是否已有该 openid 的用户
            const [existingUsers] = await pool.query(
                'SELECT * FROM users WHERE openid = ?',
                [openid]
            );

            if (existingUsers.length > 0) {
                // 已有用户，直接登录
                const user = existingUsers[0];
                // 更新微信信息
                if (nickName || avatarUrl) {
                    await pool.query(
                        'UPDATE users SET nickname = COALESCE(NULLIF(?, ""), nickname), avatar_url = COALESCE(NULLIF(?, ""), avatar_url) WHERE openid = ?',
                        [nickName, avatarUrl, openid]
                    );
                }
                return res.json({
                    success: true,
                    message: '登录成功',
                    phone: user.phone,
                    isNewUser: false
                });
            }

            // 3. 新用户 → 创建临时账号（无手机号，后续可绑定）
            const tempPhone = 'wx_' + openid.substring(0, 10);
            const defaultNickname = nickName || '微信用户';
            const defaultAvatar = avatarUrl || '';

            await pool.query(
                'INSERT INTO users (phone, password, nickname, avatar_url, openid) VALUES (?, ?, ?, ?, ?)',
                [tempPhone, '', defaultNickname, defaultAvatar, openid]
            );

            res.json({
                success: true,
                message: '注册并登录成功',
                phone: tempPhone,
                isNewUser: true
            });

        } catch (err) {
            console.error('[微信登录错误]', err);
            res.status(500).json({ success: false, message: '微信登录失败' });
        }
    },

    // 发送验证码
    sendCode(req, res) {
        const { phone } = req.body;

        if (!phone) {
            return res.status(400).json({ success: false, message: '手机号不能为空' });
        }

        // 模拟发送验证码逻辑
        const code = Math.floor(100000 + Math.random() * 900000); // 生成6位验证码
        console.log(`验证码发送到 ${phone}: ${code}`);

        // 存储验证码到内存
        global.verificationCodes = global.verificationCodes || {};
        global.verificationCodes[phone] = code;

        res.json({ success: true, message: '验证码已发送' });
    }
};