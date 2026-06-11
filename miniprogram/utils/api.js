// API 服务层 - 封装所有后端请求
const app = getApp();

const request = (url, method = 'POST', data = {}) => {
  return new Promise((resolve, reject) => {
    wx.request({
      url: `${app.globalData.baseUrl}${url}`,
      method: method,
      data: data,
      header: {
        'Content-Type': 'application/json'
      },
      success: (res) => {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          resolve(res.data);
        } else {
          reject(res.data);
        }
      },
      fail: (err) => {
        wx.showToast({
          title: '网络请求失败',
          icon: 'none',
          duration: 2000
        });
        reject(err);
      }
    });
  });
};

const api = {
  // ========== 认证相关 ==========
  // 用户注册
  register: (phone, password) => {
    return request('/auth/register', 'POST', { phone, password });
  },

  // 用户登录
  login: (phone, password) => {
    return request('/auth/login', 'POST', { phone, password });
  },

  // 微信快捷登录
  wechatLogin: (code, nickName, avatarUrl) => {
    return request('/auth/wechat-login', 'POST', { code, nickName, avatarUrl });
  },

  // 修改密码
  updatePassword: (phone, oldPassword, newPassword) => {
    return request('/auth/update-password', 'POST', { phone, oldPassword, newPassword });
  },

  // 重置密码
  resetPassword: (phone, code, newPassword) => {
    return request('/auth/reset-password', 'POST', { phone, code, newPassword });
  },

  // 发送验证码
  sendCode: (phone) => {
    return request('/auth/sendCode', 'POST', { phone });
  },

  // 获取用户信息
  getUserInfo: (phone) => {
    return request('/auth/get-user', 'POST', { phone });
  },

  // 更新用户信息
  updateUser: (data) => {
    return request('/auth/update-user', 'POST', data);
  },

  // ========== 帖子相关 ==========
  // 创建帖子
  createPost: (data) => {
    return request('/posts/create', 'POST', data);
  },

  // 获取帖子列表（分页）
  getPosts: (searchQuery = '', page = 1, pageSize = 10) => {
    return request('/posts/list', 'POST', { searchQuery, page, pageSize });
  },

  // 获取帖子详情
  getPostDetail: (postId, phone) => {
    return request('/posts/detail', 'POST', { postId, phone });
  },

  // 删除帖子
  deletePost: (post_id) => {
    return request('/posts/delete', 'POST', { post_id });
  },

  // 获取我的帖子
  getMyPosts: (phone, page = 1, pageSize = 10) => {
    return request('/posts/getMyPosts', 'POST', { phone, page, pageSize });
  },

  // ========== 评论相关 ==========
  // 创建评论
  createComment: (postId, phone, content) => {
    return request('/posts/comment/create', 'POST', { postId, phone, content });
  },

  // 删除评论
  deleteComment: (commentId) => {
    return request('/posts/comment/delete', 'POST', { commentId });
  },

  // 获取评论列表
  getComments: (postId) => {
    return request('/posts/comment/list', 'POST', { postId });
  },

  // ========== 点赞相关 ==========
  // 切换点赞
  toggleLike: (postId, phone, isLike) => {
    return request('/posts/like/toggle', 'POST', { postId, phone, isLike });
  },

  // ========== 健康数据相关 ==========
  // 保存运动记录
  saveSportRecord: (data) => {
    return request('/health/sport', 'POST', data);
  },

  // 获取运动记录
  getSportRecords: (phone, startDate, endDate) => {
    return request('/health/sport-records', 'POST', { phone, startDate, endDate });
  },

  // 获取饮食记录
  getDietRecords: (phone) => {
    return request('/health/diet-records', 'POST', { phone });
  },

  // 获取睡眠记录
  getSleepRecords: (phone) => {
    return request('/health/sleep-records', 'POST', { phone });
  },

  // 获取体重记录
  getWeightRecords: (phone) => {
    return request('/health/weight-records', 'POST', { phone });
  },

  // 检查当天记录
  checkTodayRecord: (phone) => {
    return request('/health/check-today-record', 'POST', { phone });
  },

  // 获取全部运动/食物（本地过滤用）
  getAllSports: () => {
    return request('/health/all-sports', 'GET');
  },
  getAllFoods: () => {
    return request('/health/all-foods', 'GET');
  },

  // 搜索运动
  searchSports: (keyword) => {
    return request('/health/search-sports', 'POST', { keyword });
  },

  // 搜索食物
  searchFoods: (keyword) => {
    return request('/health/search-foods', 'POST', { keyword });
  },

  // ========== AI服务相关 ==========
  // 获取健康建议
  getHealthAdvice: (phone) => {
    return request('/health/health-advice', 'POST', { phone });
  },

  // 获取每日计划
  getDailyPlan: (phone) => {
    return request('/health/daily-plan', 'POST', { phone });
  },

  // 获取激励提醒
  getMotivation: (phone) => {
    return request('/health/motivation', 'POST', { phone });
  },

  // AI答疑
  generateAIResponse: (question) => {
    return request('/health/generate-ai-response', 'POST', { question });
  },

  // 运动排行
  getSportRanking: () => {
    return request('/health/sport-ranking', 'GET');
  },

  // ========== 天气相关 ==========
  // 获取天气
  getWeather: (latitude, longitude) => {
    return request('/weather/getWeather', 'POST', { latitude, longitude });
  },

  // ========== 工具相关 ==========
  // 获取微信session key
  getSessionKey: (code) => {
    return request('/utils/getSessionKey', 'POST', { code });
  },

  // 解密微信加密数据
  decrypt: (sessionKey, encryptedData, iv) => {
    return request('/utils/decrypt', 'POST', { sessionKey, encryptedData, iv });
  }
};

module.exports = api;
