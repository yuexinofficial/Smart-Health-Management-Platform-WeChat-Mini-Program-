const router = require('express').Router();
const healthController = require('../controllers/health.controller');

// 健康数据
router.post('/sport', healthController.saveSportRecord);
router.post('/sport-records', healthController.getSportRecords);
router.post('/health-advice', healthController.getHealthAdvice);// 获取健康建议
router.post('/daily-plan', healthController.getDailyPlan);// 获取每日计划

// 其他健康数据接口
router.post('/diet-records', healthController.getDietRecords); // 获取饮食记录
router.post('/sleep-records', healthController.getSleepRecords); // 获取睡眠记录
router.post('/weight-records', healthController.getWeightRecords); // 获取体重记录
router.post('/check-today-record', healthController.checkTodayRecord); // 检查当天记录
router.post('/motivation', healthController.getMotivation); // 获取激励提醒
router.get('/all-sports', healthController.getAllSports); // 获取全部运动
router.get('/all-foods', healthController.getAllFoods); // 获取全部食物
router.post('/search-sports', healthController.searchSports); // 搜索运动
router.post('/search-foods', healthController.searchFoods); // 搜索食物
router.post('/generate-ai-response', healthController.generateAIResponse); // 生成AI响应
router.get('/sport-ranking', healthController.getSportRanking); // 新增排行榜接口

module.exports = router;