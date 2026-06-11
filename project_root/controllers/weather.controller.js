const axios = require('axios');

module.exports = {
    // 天气接口（修复版）
    async getWeather(req, res) {
        const { latitude, longitude } = req.body;
        const WEATHER_API_KEY = process.env.WEATHER_API_KEY;// 您的专属API密钥
        const API_HOST = process.env.API_HOST; // 您的专属API Host

        try {
            // 1. 获取位置ID
            const locationResponse = await axios.get(
                `https://${API_HOST}/geo/v2/city/lookup`, {
                params: {
                    location: `${longitude},${latitude}`,
                    key: WEATHER_API_KEY,
                    number: 1,
                    lang: 'zh'
                },
                headers: {
                    'X-QW-Api-Key': WEATHER_API_KEY // 添加认证头
                },
                decompress: true // 启用解压缩
            }
            );

            if (!locationResponse.data || locationResponse.data.code !== '200') {
                throw new Error(`位置查询失败: ${locationResponse.data?.message || '无返回数据'}`);
            }

            const location = locationResponse.data.location[0];
            if (!location) {
                throw new Error('未找到匹配的位置信息');
            }

            // 2. 获取实时天气
            const weatherResponse = await axios.get(
                `https://${API_HOST}/v7/weather/now`, {
                params: {
                    location: location.id,
                    key: WEATHER_API_KEY,
                    lang: 'zh',
                    unit: 'm'
                },
                headers: {
                    'X-QW-Api-Key': WEATHER_API_KEY // 添加认证头
                },
                decompress: true // 启用解压缩
            }
            );

            if (weatherResponse.data.code !== '200') {
                throw new Error(`天气查询失败: ${weatherResponse.data?.message || '未知错误'}`);
            }

            // 3. 构造响应数据
            const now = new Date();
            const hours = now.getHours();
            let timeOfDay = '早上';
            if (hours >= 12 && hours < 14) timeOfDay = '中午';
            else if (hours >= 14 && hours < 18) timeOfDay = '下午';
            else if (hours >= 18) timeOfDay = '晚上';

            res.json({
                success: true,
                location: location.name,
                temp: `${weatherResponse.data.now.temp}°C`,
                text: weatherResponse.data.now.text,
                icon: weatherResponse.data.now.icon,
                humidity: `${weatherResponse.data.now.humidity}%`,
                wind: `${weatherResponse.data.now.windDir} ${weatherResponse.data.now.windScale}级`,
                date: `${now.getMonth() + 1}月${now.getDate()}日 星期${['日', '一', '二', '三', '四', '五', '六'][now.getDay()]}`,
                time: now.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' }),
                timeOfDay
            });

        } catch (error) {
            console.error('获取天气错误详情:', {
                message: error.message,
                config: error.config,
                response: error.response?.data,
                stack: error.stack
            });

            res.status(500).json({
                success: false,
                error: '获取天气数据失败',
                detail: error.message,
                apiError: error.response?.data,
                tip: '请检查API配置或联系管理员'
            });
        }
    }
};