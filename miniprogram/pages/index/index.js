// 登录页面逻辑
const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    phone: '',
    password: '',
    showPassword: false,
    loading: false,
    wechatLoading: false
  },

  onLoad() {
    const phone = app.getPhone();
    if (phone) {
      wx.reLaunch({ url: '/pages/main/main' });
    }
  },

  // 重要：每次页面显示时重新初始化，修复 navigateBack 后 input 无法点击的问题
  onShow() {
    // navigateBack 返回时，确保页面状态正确
    // 不清空已输入的内容，但确保 data 绑定正常
    const phone = app.getPhone();
    if (phone) {
      wx.reLaunch({ url: '/pages/main/main' });
    }
  },

  // ========== 微信快捷登录 ==========
  async onWechatLogin() {
    this.setData({ wechatLoading: true });

    try {
      // 1. wx.login 获取 code
      const loginRes = await new Promise((resolve, reject) => {
        wx.login({
          success: resolve,
          fail: reject
        });
      });

      if (!loginRes.code) {
        throw new Error('获取微信登录凭证失败');
      }

      // 2. 发送 code 到后端（不传昵称头像，让后端用默认值）
      const res = await api.wechatLogin(loginRes.code, '', '');

      if (res.success) {
        app.setPhone(res.phone);
        wx.showToast({ title: res.isNewUser ? '欢迎加入！' : '登录成功', icon: 'success' });
        setTimeout(() => {
          wx.reLaunch({ url: '/pages/main/main' });
        }, 800);
      } else {
        wx.showToast({ title: res.message || '微信登录失败', icon: 'none' });
      }
    } catch (err) {
      console.error('微信登录失败:', err);
      wx.showToast({ title: '微信登录失败，请重试', icon: 'none' });
    } finally {
      this.setData({ wechatLoading: false });
    }
  },

  // ========== 手机号登录 ==========
  onPhoneInput(e) {
    this.setData({ phone: e.detail.value });
  },

  onPasswordInput(e) {
    this.setData({ password: e.detail.value });
  },

  togglePassword() {
    this.setData({ showPassword: !this.data.showPassword });
  },

  validatePhone(phone) {
    return /^1[3-9]\d{9}$/.test(phone);
  },

  async onLogin() {
    const { phone, password } = this.data;

    if (!phone) {
      wx.showToast({ title: '请输入手机号', icon: 'none' });
      return;
    }
    if (!this.validatePhone(phone)) {
      wx.showToast({ title: '请输入正确的手机号', icon: 'none' });
      return;
    }
    if (!password) {
      wx.showToast({ title: '请输入密码', icon: 'none' });
      return;
    }
    if (password.length < 6) {
      wx.showToast({ title: '密码长度不能少于6位', icon: 'none' });
      return;
    }

    this.setData({ loading: true });

    try {
      const res = await api.login(phone, password);
      if (res.success) {
        app.setPhone(phone);
        wx.showToast({ title: '登录成功', icon: 'success' });
        setTimeout(() => {
          wx.reLaunch({ url: '/pages/main/main' });
        }, 800);
      } else {
        wx.showToast({ title: res.message || '登录失败', icon: 'none' });
      }
    } catch (err) {
      wx.showToast({ title: err.message || '登录失败，请检查网络', icon: 'none' });
    } finally {
      this.setData({ loading: false });
    }
  },

  goToRegister() {
    wx.navigateTo({ url: '/pages/register/register' });
  },

  goToForgotPassword() {
    wx.navigateTo({ url: '/pages/forgotPassword/forgotPassword' });
  },

  goToAbout() {
    wx.navigateTo({ url: '/pages/about/about' });
  }
});
