// 编辑资料逻辑
const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    nickname: '',
    gender: '',
    height: '',
    avatarUrl: '',
    genderOptions: ['男', '女'],
    saving: false
  },

  onShow() {
    this.loadUserInfo();
  },

  async loadUserInfo() {
    try {
      const res = await api.getUserInfo(app.getPhone());
      if (res.success && res.userInfo) {
        const u = res.userInfo;
        this.setData({
          nickname: u.nickname || '',
          gender: u.gender || '',
          height: u.height ? String(u.height) : '',
          avatarUrl: app.getFullUrl(u.avatar_url)
        });
      }
    } catch (err) {
      console.log('加载用户信息失败:', err);
    }
  },

  // 选择头像 - 使用 wx.chooseMedia 支持更多格式
  chooseAvatar() {
    wx.chooseMedia({
      count: 1,
      mediaType: ['image'],
      sizeType: ['compressed'],
      sourceType: ['album', 'camera'],
      success: (res) => {
        const tempFilePath = res.tempFiles[0].tempFilePath;
        this.setData({ avatarUrl: tempFilePath });
        // 上传图片到服务器
        this.uploadAvatar(tempFilePath);
      }
    });
  },

  // 上传头像到服务器
  uploadAvatar(filePath) {
    wx.showLoading({ title: '上传中...' });
    wx.uploadFile({
      url: `${app.globalData.baseUrl}/auth/upload-avatar`,
      filePath: filePath,
      name: 'avatar',
      formData: {
        phone: app.getPhone()
      },
      success: (res) => {
        wx.hideLoading();
        try {
          const data = JSON.parse(res.data);
          if (data.success && data.avatarUrl) {
            // 存储完整URL
            const fullUrl = app.getFullUrl(data.avatarUrl);
            this.setData({ avatarUrl: fullUrl });
            wx.showToast({ title: '头像上传成功', icon: 'success' });
          }
        } catch (e) {
          wx.hideLoading();
        }
      },
      fail: () => {
        wx.hideLoading();
        // 上传失败，保留本地路径，保存时会一并发送
        console.log('头像上传失败，将使用本地路径');
      }
    });
  },

  onNicknameInput(e) { this.setData({ nickname: e.detail.value }); },
  onHeightInput(e) {
    const val = (e.detail.value || '').replace(/[^0-9]/g, '');
    this.setData({ height: val });
  },
  onGenderChange(e) {
    this.setData({ gender: this.data.genderOptions[e.detail.value] });
  },

  async onSave() {
    const { nickname, gender, height, avatarUrl } = this.data;

    if (!nickname.trim()) {
      wx.showToast({ title: '请输入昵称', icon: 'none' });
      return;
    }
    if (!gender) {
      wx.showToast({ title: '请选择性别', icon: 'none' });
      return;
    }
    if (!height || parseInt(height) <= 0) {
      wx.showToast({ title: '请输入有效身高', icon: 'none' });
      return;
    }

    this.setData({ saving: true });

    try {
      await api.updateUser({
        phone: app.getPhone(),
        nickname: nickname.trim(),
        gender,
        height: parseInt(height),
        avatarUrl
      });

      wx.showToast({ title: '保存成功', icon: 'success' });
      setTimeout(() => { wx.navigateBack(); }, 1000);
    } catch (err) {
      wx.showToast({ title: '保存失败', icon: 'none' });
    } finally {
      this.setData({ saving: false });
    }
  },

  goToChangePwd() {
    wx.navigateTo({ url: '/pages/forgotPassword/forgotPassword' });
  },

  goBack() { wx.navigateBack(); }
});
