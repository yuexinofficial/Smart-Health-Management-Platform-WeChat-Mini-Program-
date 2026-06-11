const router = require('express').Router();
const multer = require('multer');
const path = require('path');
const authController = require('../controllers/auth.controller');

// 配置文件上传
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadDir = path.join(__dirname, '..', 'uploads');
        const fs = require('fs');
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir, { recursive: true });
        }
        cb(null, uploadDir);
    },
    filename: (req, file, cb) => {
        const ext = path.extname(file.originalname) || '.png';
        const name = 'avatar_' + Date.now() + '_' + Math.round(Math.random() * 10000) + ext;
        cb(null, name);
    }
});

const upload = multer({
    storage,
    limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
    fileFilter: (req, file, cb) => {
        const allowed = ['.png', '.jpg', '.jpeg', '.gif', '.webp'];
        const ext = path.extname(file.originalname).toLowerCase();
        if (allowed.includes(ext)) {
            cb(null, true);
        } else {
            cb(new Error('只支持 PNG/JPG/GIF/WEBP 格式的图片'));
        }
    }
});

// 用户认证
router.post('/register', authController.register);
router.post('/login', authController.login);
router.post('/wechat-login', authController.wechatLogin);
router.post('/update-password', authController.updatePassword);
router.post('/reset-password', authController.resetPassword);

// 用户信息
router.post('/update-user', authController.updateUser);
router.post('/get-user', authController.getUserInfo);

// 头像上传
router.post('/upload-avatar', upload.single('avatar'), authController.uploadAvatar);

// 发送验证码
router.post('/sendCode', authController.sendCode);

module.exports = router;