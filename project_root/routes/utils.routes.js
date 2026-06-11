const router = require('express').Router();
const utilsController = require('../controllers/utils.controller');

// 获取 sessionKey
router.post('/getSessionKey', utilsController.getSessionKey);

// 数据解密
router.post('/decrypt', utilsController.decrypt);

module.exports = router;