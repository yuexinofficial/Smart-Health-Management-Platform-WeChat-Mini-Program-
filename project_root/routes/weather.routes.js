const router = require('express').Router();
const weatherController = require('../controllers/weather.controller');

// 获取天气
router.post('/getWeather', weatherController.getWeather);

module.exports = router;