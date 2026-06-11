# 智慧健康管理平台（微信小程序）

基于 **微信小程序 + Node.js + Express + MySQL** 的全栈健康管理应用。支持微信一键登录、运动/饮食/睡眠/体重打卡、社区发帖交流、AI 健康建议生成、微信运动步数同步等功能。

---

## 目录结构

```
Smart-Health-Management-Platform-WeChat-Mini-Program/
├── miniprogram/            # 微信小程序前端（原生框架）
│   ├── pages/              # 21 个页面
│   │   ├── index/          # 登录页
│   │   ├── main/           # 主页
│   │   ├── register/       # 注册
│   │   ├── forgotPassword/ # 忘记密码
│   │   ├── about/          # 关于我们
│   │   ├── profile/        # 个人资料
│   │   ├── editProfile/    # 编辑资料 + 头像上传
│   │   ├── checkin/        # 健康打卡
│   │   ├── sportRecord/    # 运动记录
│   │   ├── dietRecord/     # 饮食记录
│   │   ├── sleepRecord/    # 睡眠记录
│   │   ├── weightRecord/   # 体重记录
│   │   ├── community/      # 社区
│   │   ├── postDetail/     # 帖子详情 + 评论
│   │   ├── createPost/     # 发帖
│   │   ├── myPosts/        # 我的帖子
│   │   ├── healthAdvice/   # 健康建议
│   │   ├── aiChat/         # AI 健康问答
│   │   └── sportRanking/   # 运动排行
│   ├── utils/api.js        # API 封装层
│   ├── app.js / app.json   # 小程序入口与配置
│   └── images/             # 图片资源
├── project_root/           # Node.js 后端服务
│   ├── controllers/        # 控制器层 (auth/health/post/)
│   ├── routes/             # 路由定义
│   ├── config/db.js        # MySQL 连接池 + 时区配置
│   ├── app.js              # Express 应用入口 + 自动迁移
│   └── uploads/            # 用户头像上传目录
└── user_db.sql             # 数据库完整建表语句 + 种子数据
```

## 功能模块

| 模块 | 功能 |
|------|------|
| 🔐 用户认证 | 手机号注册/登录、微信一键登录（wx.login + code2session）、重置密码 |
| 📝 健康打卡 | 运动/饮食记录添加、睡眠时长/体重记录、全天数据合并保存 |
| 🔍 本地搜索 | 41 项运动 + 46 项食物预加载，打字即时过滤，无需等待网络 |
| 📊 数据记录 | 运动、饮食、睡眠、体重历史记录分页查看 |
| 💬 社区交流 | 发帖/删帖、评论/删除、点赞/取消、帖子搜索 |
| 🤖 AI 服务 | 健康建议生成、每日健康计划、激励提醒、AI 健康问答（DeepSeek） |
| 🏆 运动排行 | 运动项目热度排行榜 |
| 🌤 天气查询 | 根据用户定位获取实时天气 |
| 🚶 微信运动 | 加密步数数据同步解密 |
| 👤 个人中心 | 资料编辑、头像上传（multer）、我的帖子 |

## 技术栈

| 层面 | 技术 |
|------|------|
| 前端 | 微信小程序原生框架（WXML / WXSS / JS） |
| 后端 | Node.js + Express |
| 数据库 | MySQL（mysql2 驱动，连接池） |
| 认证 | bcrypt 密码加密、微信 code2session |
| 文件上传 | multer |
| AI 集成 | DeepSeek API（SiliconFlow） |
| 天气 | 高德地图天气 API |
| 加密 | Node.js crypto（微信运动步数解密） |

## 快速开始

### 环境要求

- Node.js 16+
- MySQL 8.0+
- 微信开发者工具

### 1. 克隆项目

```bash
git clone https://github.com/yuexinofficial/Smart-Health-Management-Platform-WeChat-Mini-Program-.git
cd Smart-Health-Management-Platform-WeChat-Mini-Program-
```

### 2. 初始化数据库

在 MySQL 中执行 `user_db.sql` 创建数据库和表结构：

```bash
mysql -u root -p < user_db.sql
```

### 3. 启动后端

```bash
cd project_root

# 创建 .env 文件，配置以下环境变量
# IP_ADDRESS = 你的本机局域网IP
# DB_USERNAME = 数据库用户名
# DB_PASSWORD = 数据库密码
# DB_DATABASE = 数据库名
# WECHAT_APPID = 微信小程序AppID
# WECHAT_SECRET = 微信小程序Secret
# DEEPSEEK_API_KEY = DeepSeek API密钥
# AMAP_API_KEY = 高德地图API密钥

npm install
npm start
```

服务启动后会自动执行数据库迁移（创建列、修复约束、插入种子数据）。

### 4. 启动小程序

1. 打开**微信开发者工具**
2. 导入 `miniprogram/` 目录
3. 填写你自己的 AppID
4. 修改 `miniprogram/app.js` 中的 `baseUrl` 为你的后端地址
5. 编译运行

## API 接口一览

### 认证 `/auth`
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/register` | 用户注册 |
| POST | `/login` | 手机号登录 |
| POST | `/wechat-login` | 微信一键登录 |
| POST | `/update-password` | 修改密码 |
| POST | `/reset-password` | 重置密码 |
| POST | `/sendCode` | 发送验证码 |
| POST | `/get-user` | 获取用户信息 |
| POST | `/update-user` | 更新用户信息 |
| POST | `/upload-avatar` | 上传头像 |

### 社区 `/posts`
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/create` | 创建帖子 |
| POST | `/list` | 帖子列表（分页+搜索） |
| POST | `/detail` | 帖子详情 |
| POST | `/delete` | 删除帖子 |
| POST | `/getMyPosts` | 我的帖子 |
| POST | `/comment/create` | 创建评论 |
| POST | `/comment/delete` | 删除评论 |
| POST | `/comment/list` | 评论列表 |
| POST | `/like/toggle` | 点赞/取消 |

### 健康 `/health`
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/sport` | 保存健康打卡记录 |
| POST | `/sport-records` | 获取运动记录 |
| POST | `/diet-records` | 获取饮食记录 |
| POST | `/sleep-records` | 获取睡眠记录 |
| POST | `/weight-records` | 获取体重记录 |
| POST | `/check-today-record` | 检查当天是否已打卡 |
| GET | `/all-sports` | 获取全部运动数据 |
| GET | `/all-foods` | 获取全部食物数据 |
| POST | `/search-sports` | 搜索运动 |
| POST | `/search-foods` | 搜索食物 |
| POST | `/health-advice` | AI 健康建议 |
| POST | `/daily-plan` | AI 每日计划 |
| POST | `/motivation` | AI 激励提醒 |
| POST | `/generate-ai-response` | AI 问答 |
| GET | `/sport-ranking` | 运动排行榜 |

### 其他
| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/weather/getWeather` | 获取天气 |
| POST | `/utils/getSessionKey` | 获取微信 session_key |
| POST | `/utils/decrypt` | 解密微信加密数据 |

## 数据库表

| 表名 | 说明 |
|------|------|
| `users` | 用户表（手机号、密码、昵称、头像、openid、身高、性别） |
| `sports` | 运动项目表（41 项种子数据） |
| `foods` | 食物数据表（46 项种子数据） |
| `sport_record` | 健康打卡记录表 |
| `community` | 社区帖子表 |
| `comments` | 评论表 |
| `post_likes` | 点赞记录表 |

## 工程亮点

- **自动数据库迁移**：服务启动时自动检测并修复表结构差异，幂等安全
- **时区一致性**：MySQL 连接层 `SET time_zone = '+08:00'` + 应用层 `localTime()` 双重保障北京时间
- **微信登录兼容**：`chk_phone` 约束支持 `wx_*` 格式的 openid 前缀，phone 列统一扩至 `VARCHAR(64)`
- **本地搜索优化**：运动/食物数据预加载到前端内存，搜索零延迟，彻底根治微信 input 组件重渲染缺陷
- **头像路径转换**：`app.getFullUrl()` 集中处理相对路径→绝对 URL，所有页面统一调用

## License

MIT
