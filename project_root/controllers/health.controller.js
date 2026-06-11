const pool = require('../config/db');
const axios = require('axios');
module.exports = {
    // 保存运动记录
    async saveSportRecord(req, res) {
        try {
            const { phone, date, sports, foods, sleep, weight } = req.body;

            // 校验必要字段
            if (!phone || !date || !sports || !foods || !sleep || !weight) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            if (!Array.isArray(sports) || !Array.isArray(foods)) {
                return res.status(400).json({ code: 'INVALID_FORMAT', message: '运动或食物数据格式错误' });
            }

            // 检查当天是否已有记录
            const [existingRecords] = await pool.query(
                'SELECT * FROM sport_record WHERE phone = ? AND DATE(record_time) = ?',
                [phone, date]
            );

            if (existingRecords.length > 0) {
                return res.status(409).json({ code: 'DUPLICATE_RECORD', message: '今日已提交过记录，请勿重复提交' });
            }

            // 合并运动数据
            const sportContent = sports.map(sport => `${sport.name}(${sport.duration}分钟)`).join('; ');
            const totalSportDuration = sports.reduce((sum, sport) => sum + sport.duration, 0);
            const totalCalorieBurned = sports.reduce((sum, sport) => sum + sport.calorie, 0);

            // 合并饮食数据
            const dietRecord = foods.map(food => `${food.name}(${food.grams}克)`).join('; ');
            const totalCalorieIntake = foods.reduce((sum, food) => sum + food.calorie, 0);

            // 插入合并后的记录
            await pool.query(
                `INSERT INTO sport_record 
            (phone, sport_content, sport_duration, calorie_burned, diet_record, calorie_intake, sleep_duration, sleep_quality, weight, record_time) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
                [
                    phone,
                    sportContent,
                    totalSportDuration,
                    totalCalorieBurned,
                    dietRecord,
                    totalCalorieIntake,
                    sleep.duration,
                    sleep.quality,
                    weight,
                    date
                ]
            );

            res.json({ success: true, message: '记录保存成功' });
        } catch (err) {
            console.error('[保存记录错误]', err);
            res.status(500).json({ code: 'SAVE_RECORD_FAILED', message: '保存记录失败' });
        }
    },

    // 获取运动记录
    async getSportRecords(req, res) {
        try {
            const { phone, startDate, endDate } = req.body;

            if (!phone) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            const [records] = await pool.query(
                `
            SELECT 
                DATE_FORMAT(record_time, '%Y-%m-%d') AS record_date, 
                sport_content, 
                sport_duration, 
                calorie_burned 
            FROM sport_record 
            WHERE phone = ? AND record_time BETWEEN ? AND ? 
            ORDER BY record_time DESC
            `,
                [phone, startDate || '1970-01-01', endDate || '9999-12-31']
            );

            res.json({ success: true, records });
        } catch (err) {
            console.error('[获取运动记录错误]', err);
            res.status(500).json({ code: 'GET_SPORT_RECORDS_FAILED', message: '获取运动记录失败' });
        }
    },

    // 获取健康建议
    async getHealthAdvice(req, res) {
        const { phone } = req.body;

        if (!phone) {
            return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
        }

        try {
            // 获取近7天数据
            const sevenDaysData = await getHealthData(phone, 7);

            // 获取昨日数据
            const yesterdayData = await getHealthData(phone, 1, 1);

            // 调用AI生成建议
            const advice = await callDeepSeekAI({
                sevenDays: sevenDaysData,
                yesterday: yesterdayData[0] || {}
            });

            res.status(200).send({ advice });
        } catch (err) {
            console.error('[获取健康建议错误]', err);
            res.status(500).send({ code: 'GET_HEALTH_ADVICE_FAILED', message: '获取健康建议失败' });
        }
    },
    // 生成健康计划
    async getDailyPlan(req, res) {
        const { phone } = req.body;

        if (!phone) {
            return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
        }

        try {
            // 获取用户基础数据
            const [basicData] = await pool.query(
                `SELECT height, gender FROM users WHERE phone = ?`,
                [phone]
            );

            if (basicData.length === 0) {
                return res.status(404).json({ code: 'USER_NOT_FOUND', message: '用户不存在' });
            }

            // 获取最近的体重记录
            const [weightData] = await pool.query(
                `SELECT weight FROM sport_record WHERE phone = ? ORDER BY record_time DESC LIMIT 1`,
                [phone]
            );

            const weight = weightData.length > 0 ? weightData[0].weight : null;

            // 构造AI提示词
            const prompt = `基于健康管理常识，为手机号为${phone}的用户生成今日健康计划，包含运动、饮食、睡眠等方面，用中文返回，不超过200字。用户信息：身高${basicData[0].height}厘米，性别${basicData[0].gender}${weight ? `，体重${weight}公斤` : ''}。`;

            // 调用AI生成健康计划
            const plan = await callDeepSeekAI({ prompt });

            res.status(200).send({ plan });
        } catch (err) {
            console.error('[生成健康计划错误]', err);
            res.status(500).send({ code: 'GET_DAILY_PLAN_FAILED', message: '生成健康计划失败' });
        }
    },

    // 获取饮食记录
    async getDietRecords(req, res) {
        try {
            const { phone } = req.body;

            if (!phone) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            const [records] = await pool.query(
                `
            SELECT 
                DATE_FORMAT(record_time, '%Y-%m-%d') AS record_date, 
                diet_record, 
                calorie_intake 
            FROM sport_record 
            WHERE phone = ? 
            ORDER BY record_time DESC
            `,
                [phone]
            );

            res.json({ success: true, records });
        } catch (err) {
            console.error('[获取饮食记录错误]', err);
            res.status(500).json({ code: 'GET_DIET_RECORDS_FAILED', message: '获取饮食记录失败' });
        }
    },

    // 获取睡眠记录
    async getSleepRecords(req, res) {
        try {
            const { phone } = req.body;

            if (!phone) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            const [records] = await pool.query(
                `
            SELECT 
                DATE_FORMAT(record_time, '%Y-%m-%d') AS record_date, 
                sleep_duration, 
                sleep_quality 
            FROM sport_record 
            WHERE phone = ? 
            ORDER BY record_time DESC
            `,
                [phone]
            );

            res.json({ success: true, records });
        } catch (err) {
            console.error('[获取睡眠记录错误]', err);
            res.status(500).json({ code: 'GET_SLEEP_RECORDS_FAILED', message: '获取睡眠记录失败' });
        }
    },

    // 获取体重记录
    async getWeightRecords(req, res) {
        try {
            const { phone } = req.body;

            if (!phone) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            const [records] = await pool.query(
                `
            SELECT 
                DATE_FORMAT(record_time, '%Y-%m-%d') AS record_date, 
                weight, 
                height 
            FROM sport_record 
            WHERE phone = ? 
            ORDER BY record_time DESC
            `,
                [phone]
            );

            res.json({ success: true, records });
        } catch (err) {
            console.error('[获取体重记录错误]', err);
            res.status(500).json({ code: 'GET_WEIGHT_RECORDS_FAILED', message: '获取体重记录失败' });
        }
    },

    // 检查当天记录
    async checkTodayRecord(req, res) {
        try {
            const { phone } = req.body;

            if (!phone) {
                return res.status(400).json({ code: 'MISSING_FIELDS', message: '缺少必要字段' });
            }

            const [records] = await pool.query(
                'SELECT * FROM sport_record WHERE phone = ? AND DATE(record_time) = CURDATE()',
                [phone]
            );

            res.json({ success: true, hasRecord: records.length > 0 });
        } catch (err) {
            console.error('[检查当天记录错误]', err);
            res.status(500).json({ code: 'CHECK_TODAY_RECORD_FAILED', message: '检查当天记录失败' });
        }
    },

    // 获取激励提醒
    async getMotivation(req, res) {
        const { phone } = req.body;
        const SILICONFLOW_API_KEY = process.env.DEEPSEEK_API_KEY; // 替换为你的 SiliconFlow API 密钥

        try {
            // 获取近30天健康数据
            const records = await getHealthData(phone, 30);

            // 构造AI提示词
            const prompt = `根据用户近30天的健康数据生成激励提醒，要求：
1. 包含积极鼓励和改进建议
2. 关注连续打卡、运动量变化等核心指标
3. 使用口语化中文，不超过80字
4. 示例："最近三天运动量持续增加，继续保持！" 或 "今日步数不足目标值，快起来走走吧！"

健康数据：
${JSON.stringify(records.slice(0, 5))}...（共${records.length}条记录）`;

            // 调用AI接口
            const response = await axios.post(
                'https://api.siliconflow.cn/v1/chat/completions',
                {
                    model: "Qwen/Qwen2.5-72B-Instruct",
                    messages: [{
                        role: "user",
                        content: prompt
                    }],
                    temperature: 0.5
                },
                {
                    headers: {
                        'Authorization': `Bearer ${SILICONFLOW_API_KEY}`,
                        'Content-Type': 'application/json'
                    }
                }
            );

            const advice = response.data.choices[0].message.content;
            res.status(200).send({ advice });

        } catch (err) {
            console.error('[激励错误] 完整错误信息:', {
                message: err.message,
                response: err.response?.data,
                stack: err.stack
            });
            res.status(500).send({
                error: '生成激励信息失败',
                detail: err.response?.data?.error?.message || err.message
            });
        }
    },

    // 获取全部运动
    async getAllSports(req, res) {
        try {
            const [results] = await pool.query(
                'SELECT sport_id, name, calorie_per_hour FROM sports ORDER BY name'
            );
            res.json({ code: 200, message: 'success', data: results });
        } catch (err) {
            console.error('[获取全部运动错误]', err);
            res.status(500).json({ code: 'GET_ALL_SPORTS_FAILED', message: '获取运动数据失败' });
        }
    },

    // 获取全部食物
    async getAllFoods(req, res) {
        try {
            const [results] = await pool.query(
                'SELECT food_id, name, calorie_per_100g FROM foods ORDER BY name'
            );
            res.json({ code: 200, message: 'success', data: results });
        } catch (err) {
            console.error('[获取全部食物错误]', err);
            res.status(500).json({ code: 'GET_ALL_FOODS_FAILED', message: '获取食物数据失败' });
        }
    },

    // 运动搜索
    async searchSports(req, res) {
        try {
            const { keyword } = req.body;
            const [results] = await pool.query(
                `SELECT sport_id, name, calorie_per_hour 
                FROM sports 
                WHERE name LIKE CONCAT('%', ?, '%') 
                LIMIT 20`,
                [keyword]
            );

            res.json({
                code: 200,
                message: 'success',
                data: results
            });
        } catch (err) {
            console.error('[运动搜索错误]', err);
            res.status(500).json({
                code: 'SEARCH_ERROR',
                message: '搜索服务不可用'
            });
        }
    },

    // 食物搜索
    async searchFoods(req, res) {
        try {
            const { keyword } = req.body;
            const [results] = await pool.query(
                `SELECT food_id, name, calorie_per_100g 
                FROM foods 
                WHERE name LIKE CONCAT('%', ?, '%') 
                LIMIT 20`,
                [keyword]
            );

            res.json({
                code: 200,
                message: 'success',
                data: results
            });
        } catch (err) {
            console.error('[食物搜索错误]', err);
            res.status(500).json({
                code: 'SEARCH_ERROR',
                message: '搜索服务不可用'
            });
        }
    },
    async generateAIResponse(req, res) {
        const { question } = req.body;
        console.log('收到请求，问题内容:', question);
        if (!question) {
            console.warn('问题参数缺失');
            return res.status(400).json({ code: 'MISSING_FIELDS', message: '问题不能为空' });
        }

        const SILICONFLOW_API_KEY = process.env.DEEPSEEK_API_KEY;
        console.log('使用的API密钥:', SILICONFLOW_API_KEY ? '已设置' : '未设置'); // ✅ 检查密钥

        try {
            const prompt = `用户提问：${question}\n请用中文回答。`;
            console.log('构造的提示词:', prompt);

            const response = await axios.post(
                'https://api.siliconflow.cn/v1/chat/completions',
                {
                    model: "Qwen/Qwen2.5-72B-Instruct",
                    messages: [{ role: "user", content: prompt }],
                    temperature: 0.7
                },
                {
                    headers: {
                        'Authorization': `Bearer ${SILICONFLOW_API_KEY}`,
                        'Content-Type': 'application/json'
                    },
                    timeout: 30000 // 设置超时时间为10秒
                }
            );
            const advice = response.data.choices[0].message.content;
            res.status(200).send({ advice });
            console.log('硅流API响应:', advice);
        } catch (err) {
            console.error('[AI调用错误] 状态码:', err.response?.status);
            console.error('[AI调用错误] 响应数据:', err.response?.data);
            console.error('[AI调用错误] 堆栈:', err.stack);
            res.status(500).json({ code: 'AI_RESPONSE_FAILED', message: '生成AI回复失败' });
        }
    },
    // 新增排行榜接口
    async getSportRanking(req, res) {
        try {
            const [ranking] = await pool.query(`
                SELECT 
                    sport_content,
                    COUNT(*) AS frequency 
                FROM sport_record 
                GROUP BY sport_content 
                ORDER BY frequency DESC 
                LIMIT 3
            `);

            res.json({
                code: 200,
                message: 'success',
                data: ranking
            });
        } catch (err) {
            console.error('[获取排行榜错误]', err);
            res.status(500).json({
                code: 'GET_RANKING_FAILED',
                message: '获取排行榜数据失败'
            });
        }
    }
};
// 获取健康数据的通用方法
async function getHealthData(phone, days, offset = 0) {
    const pad = n => String(n).padStart(2, '0');
    const fmt = d => `${d.getFullYear()}-${pad(d.getMonth()+1)}-${pad(d.getDate())} ${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}`;

    const endDate = new Date();
    endDate.setDate(endDate.getDate() - offset);
    endDate.setHours(23, 59, 59, 999);

    const startDate = new Date(endDate);
    startDate.setDate(endDate.getDate() - (days - 1));
    startDate.setHours(0, 0, 0, 0);

    const [records] = await pool.query(
        `SELECT
            DATE_FORMAT(record_time, '%Y-%m-%d') AS date,
            sport_duration,
            calorie_burned,
            diet_record,
            calorie_intake,
            sleep_duration,
            sleep_quality,
            weight
        FROM sport_record
        WHERE phone = ?
          AND record_time BETWEEN ? AND ?
        ORDER BY record_time DESC`,
        [
            phone,
            fmt(startDate),
            fmt(endDate)
        ]
    );

    return records;
}
// 调用AI接口的通用方法
async function callDeepSeekAI({ prompt, sevenDays, yesterday }) {
    const SILICONFLOW_API_KEY = process.env.DEEPSEEK_API_KEY; // 替换为你的 SiliconFlow API 密钥

    try {
        const response = await axios.post(
            'https://api.siliconflow.cn/v1/chat/completions',
            {
                model: "Qwen/Qwen2.5-72B-Instruct",
                messages: [{
                    role: "user",
                    content: prompt || `分析用户最近7天的健康数据，对比昨日数据给出专业建议，用中文返回，包含运动、饮食、睡眠、体重四个方面，每个方面不超过100字。\n\n最近7天数据：${JSON.stringify(sevenDays)}\n昨日数据：${JSON.stringify(yesterday)}`
                }],
                temperature: 0.7
            },
            {
                headers: {
                    'Authorization': `Bearer ${SILICONFLOW_API_KEY}`,
                    'Content-Type': 'application/json'
                }
            }
        );

        return response.data.choices[0].message.content;
    } catch (err) {
        console.error('[AI服务错误]', err.response?.data || err.message);
        throw new Error('AI服务不可用');
    }
}
