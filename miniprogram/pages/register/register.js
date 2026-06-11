// 注册页面逻辑
const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    phone: '',
    password: '',
    confirmPassword: '',
    showPassword: false,
    showConfirm: false,
    phoneError: '',
    passwordError: '',
    confirmError: '',
    loading: false
  },

  onPhoneInput(e) {
    const phone = e.detail.value;
    this.setData({ phone, phoneError: '' });
    if (phone && !/^1[3-9]\d{9}$/.test(phone)) {
      this.setData({ phoneError: '请输入正确的手机号' });
    }
  },

  onPasswordInput(e) {
    const password = e.detail.value;
    this.setData({ password, passwordError: '' });
    if (password && password.length < 6) {
      this.setData({ passwordError: '密码长度不能少于6位' });
    }
  },

  onConfirmPasswordInput(e) {
    const confirmPassword = e.detail.value;
    const { password } = this.data;
    this.setData({ confirmPassword, confirmError: '' });
    if (confirmPassword && password !== confirmPassword) {
      this.setData({ confirmError: '两次输入的密码不一致' });
    }
  },

  togglePassword() {
    this.setData({ showPassword: !this.data.showPassword });
  },

  async onRegister() {
    const { phone, password, confirmPassword } = this.data;

    let hasError = false;
    if (!phone) {
      this.setData({ phoneError: '请输入手机号' });
      hasError = true;
    } else if (!/^1[3-9]\d{9}$/.test(phone)) {
      this.setData({ phoneError: '请输入正确的手机号' });
      hasError = true;
    }
    if (!password) {
      this.setData({ passwordError: '请输入密码' });
      hasError = true;
    } else if (password.length < 6) {
      this.setData({ passwordError: '密码长度不能少于6位' });
      hasError = true;
    }
    if (!confirmPassword) {
      this.setData({ confirmError: '请确认密码' });
      hasError = true;
    } else if (password !== confirmPassword) {
      this.setData({ confirmError: '两次输入的密码不一致' });
      hasError = true;
    }

    if (hasError) return;

    this.setData({ loading: true });

    try {
      const res = await api.register(phone, password);
      if (res.success) {
        // 注册成功 → 自动登录
        app.setPhone(phone);
        wx.showToast({ title: '注册成功', icon: 'success' });
        setTimeout(() => {
          wx.reLaunch({ url: '/pages/main/main' });
        }, 800);
      } else {
        wx.showToast({ title: res.message || '注册失败', icon: 'none' });
      }
    } catch (err) {
      wx.showToast({ title: err.message || '注册失败，请检查网络', icon: 'none' });
    } finally {
      this.setData({ loading: false });
    }
  },

  onBack() {
    wx.navigateBack();
  }
});
