App({
  globalData: {
    phone: '',
    openid: '',
    userInfo: null,
    baseUrl: 'http://192.168.43.66:3000'
  },

  onLaunch() {
    // 检查本地存储中是否有登录信息
    const phone = wx.getStorageSync('phone');
    if (phone) {
      this.globalData.phone = phone;
    }
    const openid = wx.getStorageSync('openid');
    if (openid) {
      this.globalData.openid = openid;
    }
  },

  // 设置用户手机号
  setPhone(phone) {
    this.globalData.phone = phone;
    wx.setStorageSync('phone', phone);
  },

  // 获取用户手机号
  getPhone() {
    return this.globalData.phone || wx.getStorageSync('phone') || '';
  },

  // 设置 openid
  setOpenid(openid) {
    this.globalData.openid = openid;
    wx.setStorageSync('openid', openid);
  },

  // 获取 openid
  getOpenid() {
    return this.globalData.openid || wx.getStorageSync('openid') || '';
  },

  // 获取完整图片URL（处理相对路径）
  getFullUrl(path) {
    if (!path) return '/images/avatar.png';
    if (path.startsWith('http://') || path.startsWith('https://')) return path;
    if (path.startsWith('/uploads/')) return this.globalData.baseUrl + path;
    return path;
  },

  // 退出登录
  logout() {
    this.globalData.phone = '';
    this.globalData.openid = '';
    this.globalData.userInfo = null;
    wx.removeStorageSync('phone');
    wx.removeStorageSync('openid');
    wx.removeStorageSync('userInfo');
  }
});
