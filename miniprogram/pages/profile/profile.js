// 个人中心逻辑
const api = require('../../utils/api');
const app = getApp();

Page({
  data: { phone: '', userInfo: {} },

  onShow() {
    const phone = app.getPhone();
    this.setData({ phone });
    if (phone) this.loadUserInfo();
  },

  async loadUserInfo() {
    try {
      const res = await api.getUserInfo(app.getPhone());
      if (res.success && res.userInfo) {
        const u = res.userInfo;
        u.avatar_url = app.getFullUrl(u.avatar_url);
        this.setData({ userInfo: u });
      }
    } catch (err) {
      console.log('获取用户信息失败:', err);
    }
  },

  goToMyPosts() { wx.navigateTo({ url: '/pages/myPosts/myPosts' }); },
  goToEditProfile() { wx.navigateTo({ url: '/pages/editProfile/editProfile' }); },
  goToAbout() { wx.navigateTo({ url: '/pages/about/about' }); },

  onLogout() {
    wx.showModal({
      title: '提示',
      content: '确定要退出登录吗？',
      success: (res) => {
        if (res.confirm) {
          app.logout();
          wx.reLaunch({ url: '/pages/index/index' });
        }
      }
    });
  }
});
