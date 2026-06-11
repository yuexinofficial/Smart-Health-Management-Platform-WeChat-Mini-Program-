require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const app = express();

// 中间件
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '10mb' }));
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
});

// 静态文件服务 - 上传的头像
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// 路由
app.use('/auth', require('./routes/auth.routes'));
app.use('/posts', require('./routes/post.routes'));
app.use('/health', require('./routes/health.routes'));
app.use('/utils', require('./routes/utils.routes'));
app.use('/weather', require('./routes/weather.routes'));

// 错误处理中间件
app.use((err, req, res, next) => {
    console.error('[全局错误]', err.stack);
    res.status(500).json({
        code: 'SERVER_ERROR',
        message: '服务器内部错误',
        timestamp: new Date().toISOString()
    });
});

const PORT = process.env.PORT || 3000;
const IP_address = process.env.IP_ADDRESS || 'localhost';

// 数据库自动迁移
const pool = require('./config/db');
async function autoMigrate() {
  // 1. 添加 openid 列（如果不存在）
  try {
    await pool.query(`ALTER TABLE users ADD COLUMN openid VARCHAR(64) DEFAULT NULL`);
    console.log('[迁移] openid 列已添加');
  } catch (err) {
    if (err.code === 'ER_DUP_FIELDNAME') {
      console.log('[迁移] openid 列已存在，跳过');
    } else {
      console.log('[迁移] 跳过 openid:', err.message);
    }
  }
  // 2. openid 索引
  try {
    await pool.query(`CREATE INDEX idx_openid ON users (openid)`);
  } catch (err) { /* 已存在则跳过 */ }

  // 3. 修复 phone 约束 — 允许 wx_ 前缀（微信用户）或纯数字
  try {
    await pool.query(`ALTER TABLE users DROP CONSTRAINT chk_phone`);
    await pool.query(`ALTER TABLE users ADD CONSTRAINT chk_phone CHECK (
      regexp_like(phone, _utf8mb4'^[0-9]{1,12}$')
      OR phone LIKE 'wx_%'
    )`);
    console.log('[迁移] chk_phone 约束已更新（支持微信用户）');
  } catch (err) {
    console.log('[迁移] chk_phone 更新:', err.message);
  }

  // 4. comments 表 — 加宽 phone 列 + 更新约束
  try {
    await pool.query(`ALTER TABLE comments DROP FOREIGN KEY comments_ibfk_2`);
  } catch (err) { /* FK可能不存在 */ }
  try {
    await pool.query(`ALTER TABLE comments DROP CONSTRAINT comments_chk_3`);
  } catch (err) { /* */ }
  try {
    await pool.query(`ALTER TABLE comments MODIFY COLUMN phone VARCHAR(64) NOT NULL`);
    await pool.query(`ALTER TABLE comments ADD CONSTRAINT comments_chk_3 CHECK (
      phone REGEXP '^[0-9]{1,12}$' OR phone LIKE 'wx_%'
    )`);
    console.log('[迁移] comments.phone → VARCHAR(64)');
  } catch (err) {
    console.log('[迁移] comments 修改:', err.message);
  }

  // 5. community 表 — 加宽 phone 列 + 更新约束
  try {
    await pool.query(`ALTER TABLE community DROP FOREIGN KEY community_ibfk_1`);
  } catch (err) { /* FK 可能已被删 */ }
  try {
    await pool.query(`ALTER TABLE community DROP CONSTRAINT community_chk_6`);
  } catch (err) { /* 可能已删除 */ }
  try {
    await pool.query(`ALTER TABLE community MODIFY COLUMN phone VARCHAR(64) NOT NULL`);
    await pool.query(`ALTER TABLE community ADD CONSTRAINT community_chk_6 CHECK (
      phone REGEXP '^[0-9]{1,12}$' OR phone LIKE 'wx_%'
    )`);
    console.log('[迁移] community.phone → VARCHAR(64)');
  } catch (err) {
    console.log('[迁移] community 修改:', err.message);
  }

  // 6. sport_record 表 — 加宽 phone 列 + 更新约束
  try {
    await pool.query(`ALTER TABLE sport_record DROP CONSTRAINT chk_phone_format`);
  } catch (err) { /* */ }
  try {
    await pool.query(`ALTER TABLE sport_record MODIFY COLUMN phone VARCHAR(64) NOT NULL`);
    await pool.query(`ALTER TABLE sport_record ADD CONSTRAINT chk_phone_format CHECK (
      phone REGEXP '^[0-9]{1,12}$' OR phone LIKE 'wx_%'
    )`);
    console.log('[迁移] sport_record.phone → VARCHAR(64)');
  } catch (err) {
    console.log('[迁移] sport_record 修改:', err.message);
  }

  // 7. 恢复 community 外键（如需要）
  try {
    await pool.query(`ALTER TABLE community ADD CONSTRAINT community_ibfk_1
      FOREIGN KEY (phone) REFERENCES users(phone) ON DELETE RESTRICT ON UPDATE RESTRICT`);
  } catch (err) { /* 已存在则跳过 */ }

  // 8. sports 表种子数据（如为空）
  try {
    const [sportsCount] = await pool.query('SELECT COUNT(*) as cnt FROM sports');
    if (sportsCount[0].cnt === 0) {
      const seedSports = [
        ['跑步','有氧运动',600],['快走','有氧运动',350],['慢走','有氧运动',200],
        ['游泳','有氧运动',550],['骑行','有氧运动',450],['跳绳','有氧运动',700],
        ['爬楼梯','有氧运动',500],['瑜伽','柔韧训练',250],['太极','柔韧训练',280],
        ['普拉提','柔韧训练',300],['仰卧起坐','力量训练',400],['俯卧撑','力量训练',450],
        ['深蹲','力量训练',500],['引体向上','力量训练',480],['哑铃训练','力量训练',350],
        ['篮球','球类运动',450],['足球','球类运动',500],['羽毛球','球类运动',350],
        ['乒乓球','球类运动',280],['网球','球类运动',400],['排球','球类运动',300],
        ['高尔夫','休闲运动',250],['保龄球','休闲运动',200],['爬山','户外运动',450],
        ['攀岩','户外运动',550],['滑雪','户外运动',500],['滑冰','户外运动',400],
        ['划船','水上运动',450],['冲浪','水上运动',420],['椭圆机','有氧运动',480],
        ['动感单车','有氧运动',520],['HIIT训练','有氧运动',650],['搏击操','有氧运动',550],
        ['跳操','有氧运动',400],['拳击','力量训练',600],['拉伸','柔韧训练',150],
        ['俯身划船','力量训练',380],['平板支撑','力量训练',320],['波比跳','有氧运动',700],
        ['开合跳','有氧运动',500],['跳舞','有氧运动',350]
      ];
      for (const s of seedSports) {
        await pool.query('INSERT INTO sports (name, category, calorie_per_hour) VALUES (?,?,?)', s);
      }
      console.log('[迁移] 已插入 ' + seedSports.length + ' 条运动数据');
    }
  } catch (err) {
    console.log('[迁移] sports 种子:', err.message);
  }

  // 9. foods 表种子数据（如为空）
  try {
    const [foodsCount] = await pool.query('SELECT COUNT(*) as cnt FROM foods');
    if (foodsCount[0].cnt === 0) {
      const seedFoods = [
        ['白米饭','主食',116],['馒头','主食',223],['面条','主食',110],['小米粥','主食',46],
        ['全麦面包','主食',246],['红薯','主食',86],['玉米','主食',112],['土豆','主食',76],
        ['鸡蛋','蛋奶',144],['牛奶','蛋奶',65],['酸奶','蛋奶',72],['奶酪','蛋奶',328],
        ['鸡胸肉','肉类',133],['牛肉','肉类',250],['猪肉','肉类',395],['羊肉','肉类',294],
        ['鸭肉','肉类',240],['三文鱼','水产',208],['虾仁','水产',99],['带鱼','水产',127],
        ['豆腐','豆制品',76],['豆浆','豆制品',33],['黄豆','豆制品',390],
        ['西红柿','蔬菜',18],['黄瓜','蔬菜',15],['胡萝卜','蔬菜',37],['西兰花','蔬菜',22],
        ['菠菜','蔬菜',23],['生菜','蔬菜',15],['白菜','蔬菜',13],['芹菜','蔬菜',14],
        ['苹果','水果',53],['香蕉','水果',93],['橙子','水果',48],['葡萄','水果',70],
        ['西瓜','水果',31],['草莓','水果',32],['蓝莓','水果',57],['猕猴桃','水果',61],
        ['核桃','坚果',654],['花生','坚果',563],['杏仁','坚果',578],['腰果','坚果',553],
        ['巧克力','零食',546],['薯片','零食',536],['饼干','零食',433],['蛋糕','零食',347]
      ];
      for (const f of seedFoods) {
        await pool.query('INSERT INTO foods (name, category, calorie_per_100g) VALUES (?,?,?)', f);
      }
      console.log('[迁移] 已插入 ' + seedFoods.length + ' 条食物数据');
    }
  } catch (err) {
    console.log('[迁移] foods 种子:', err.message);
  }
}
autoMigrate();

// 启动服务器
app.listen(PORT, () => {
    console.log(`Server running at http://${IP_address}:${PORT}`);
});