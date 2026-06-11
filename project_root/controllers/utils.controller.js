const axios = require('axios');
const crypto = require('crypto');

module.exports = {
    async getSessionKey(req, res) {
        try {
            const { code } = req.body;
            const appid = process.env.WX_APPID; // 微信小程序的 AppID
            const secret = process.env.WX_SECRET; // 微信小程序的 AppSecret

            const response = await axios.get(
                `https://api.weixin.qq.com/sns/jscode2session?appid=${appid}&secret=${secret}&js_code=${code}&grant_type=authorization_code`
            );

            if (response.data.errcode) {
                throw new Error(response.data.errmsg);
            }

            res.json({
                session_key: response.data.session_key,
                openid: response.data.openid,
            });
        } catch (error) {
            console.error('获取 sessionKey 失败:', error);
            res.status(500).json({ error: '获取 sessionKey 失败' });
        }
    },

    decrypt(req, res) {
        try {
            const { sessionKey, encryptedData, iv } = req.body;

            const sessionKeyBuffer = Buffer.from(sessionKey, 'base64');
            const encryptedDataBuffer = Buffer.from(encryptedData, 'base64');
            const ivBuffer = Buffer.from(iv, 'base64');

            const decipher = crypto.createDecipheriv('aes-128-cbc', sessionKeyBuffer, ivBuffer);
            decipher.setAutoPadding(true);

            let decoded = decipher.update(encryptedDataBuffer, 'binary', 'utf8');
            decoded += decipher.final('utf8');

            res.json(JSON.parse(decoded));
        } catch (error) {
            console.error('解密失败:', error);
            res.status(500).json({ error: '数据解密失败' });
        }
    },
};