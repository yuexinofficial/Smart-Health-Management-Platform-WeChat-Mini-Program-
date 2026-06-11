// 主页逻辑
const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    steps: 0,
    motivation: '',
    weather: null,
    greetingText: '',
    avatarUrl: '/images/avatar.png'
  },

  onShow() {
    const phone = app.getPhone();
    if (!phone) {
      wx.reLaunch({ url: '/pages/index/index' });
      return;
    }
    this.setGreeting();
    this.loadPageData();
    this.loadAvatar();
  },

  onLoad() {
    const phone = app.getPhone();
    if (phone) {
      this.setGreeting();
      this.loadPageData();
      this.loadAvatar();
    }
  },

  setGreeting() {
    const hour = new Date().getHours();
    let text = '早上好';
    if (hour >= 6 && hour < 12) text = '早上好 ☀️';
    else if (hour >= 12 && hour < 14) text = '中午好 🌤️';
    else if (hour >= 14 && hour < 18) text = '下午好 🌈';
    else if (hour >= 18 && hour < 22) text = '晚上好 🌙';
    else text = '夜深了 🌙';
    this.setData({ greetingText: text });
  },

  async loadAvatar() {
    try {
      const res = await api.getUserInfo(app.getPhone());
      if (res.success && res.userInfo && res.userInfo.avatar_url) {
        this.setData({ avatarUrl: app.getFullUrl(res.userInfo.avatar_url) });
      }
    } catch (err) {
      console.log('加载头像失败:', err);
    }
  },

  async loadPageData() {
    this.getWeRunData();
    this.getMotivation();
    this.getWeather();
  },

  getWeRunData() {
    wx.getWeRunData({
      success: (res) => {
        wx.login({
          success: async (loginRes) => {
            try {
              const sessionRes = await api.getSessionKey(loginRes.code);
              const decryptRes = await api.decrypt(
                sessionRes.session_key,
                res.encryptedData,
                res.iv
              );
              if (decryptRes && decryptRes.stepInfoList) {
                const today = decryptRes.stepInfoList[decryptRes.stepInfoList.length - 1];
                this.setData({ steps: today ? today.step : 0 });
              }
            } catch (err) {
              // 解密失败是常见的（特别是开发工具中），静默处理
              console.log('步数解密失败（开发工具中常见），步数显示为 0');
              this.setData({ steps: 0 });
            }
          }
        });
      },
      fail: () => {
        console.log('用户未授权微信运动');
        this.setData({ steps: 0 });
      }
    });
  },

  async getMotivation() {
    try {
      const phone = app.getPhone();
      const res = await api.getMotivation(phone);
      if (res && res.advice) {
        this.setData({ motivation: res.advice });
      }
    } catch (err) {
      console.log('获取激励失败:', err);
    }
  },

  async getWeather() {
    wx.getLocation({
      type: 'gcj02',
      success: async (res) => {
        try {
          const weatherRes = await api.getWeather(res.latitude, res.longitude);
          if (weatherRes.success) {
            this.setData({ weather: weatherRes });
          }
        } catch (err) {
          console.log('获取天气失败:', err);
        }
      },
      fail: () => {
        console.log('获取位置失败');
      }
    });
  },

  goToProfile() {
    wx.switchTab({ url: '/pages/profile/profile' });
  },

  goToCheckin() { wx.navigateTo({ url: '/pages/checkin/checkin' }); },
  goToSportRecord() { wx.navigateTo({ url: '/pages/sportRecord/sportRecord' }); },
  goToDietRecord() { wx.navigateTo({ url: '/pages/dietRecord/dietRecord' }); },
  goToSleepRecord() { wx.navigateTo({ url: '/pages/sleepRecord/sleepRecord' }); },
  goToWeightRecord() { wx.navigateTo({ url: '/pages/weightRecord/weightRecord' }); },
  goToHealthAdvice() { wx.navigateTo({ url: '/pages/healthAdvice/healthAdvice' }); },
  goToAIChat() { wx.navigateTo({ url: '/pages/aiChat/aiChat' }); },
  goToSportRanking() { wx.navigateTo({ url: '/pages/sportRanking/sportRanking' }); }
});
