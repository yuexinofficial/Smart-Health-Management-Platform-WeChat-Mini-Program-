// 忘记密码页面逻辑
const api = require('../../utils/api');

Page({
  data: {
    phone: '',
    code: '',
    newPassword: '',
    showPassword: false,
    countdown: 0,
    loading: false
  },

  onPhoneInput(e) { this.setData({ phone: e.detail.value }); },
  onCodeInput(e) { this.setData({ code: e.detail.value }); },
  onNewPasswordInput(e) { this.setData({ newPassword: e.detail.value }); },

  togglePassword() {
    this.setData({ showPassword: !this.data.showPassword });
  },

  async sendCode() {
    const { phone } = this.data;
    if (!phone) {
      wx.showToast({ title: '请输入手机号', icon: 'none' });
      return;
    }
    if (!/^1[3-9]\d{9}$/.test(phone)) {
      wx.showToast({ title: '请输入正确的手机号', icon: 'none' });
      return;
    }

    try {
      await api.sendCode(phone);
      wx.showToast({ title: '验证码已发送', icon: 'success' });

      this.setData({ countdown: 60 });
      const timer = setInterval(() => {
        if (this.data.countdown <= 1) {
          clearInterval(timer);
          this.setData({ countdown: 0 });
        } else {
          this.setData({ countdown: this.data.countdown - 1 });
        }
      }, 1000);
    } catch (err) {
      wx.showToast({ title: '发送验证码失败', icon: 'none' });
    }
  },

  async onReset() {
    const { phone, code, newPassword } = this.data;

    if (!phone) { wx.showToast({ title: '请输入手机号', icon: 'none' }); return; }
    if (!code) { wx.showToast({ title: '请输入验证码', icon: 'none' }); return; }
    if (!newPassword || newPassword.length < 6) {
      wx.showToast({ title: '新密码至少6位', icon: 'none' });
      return;
    }

    this.setData({ loading: true });

    try {
      const res = await api.resetPassword(phone, code, newPassword);
      if (res.success) {
        wx.showToast({ title: '密码重置成功', icon: 'success' });
        setTimeout(() => { wx.navigateBack(); }, 1000);
      } else {
        wx.showToast({ title: res.message || '重置失败', icon: 'none' });
      }
    } catch (err) {
      wx.showToast({ title: err.message || '重置密码失败', icon: 'none' });
    } finally {
      this.setData({ loading: false });
    }
  },

  onBack() { wx.navigateBack(); }
});
