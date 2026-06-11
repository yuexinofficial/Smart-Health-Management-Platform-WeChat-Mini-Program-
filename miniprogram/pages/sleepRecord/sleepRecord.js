const api = require('../../utils/api');
const app = getApp();

Page({
  data: { records: [] },
  onShow() { this.loadRecords(); },
  async loadRecords() {
    try {
      const res = await api.getSleepRecords(app.getPhone());
      if (res.success) this.setData({ records: res.records || [] });
    } catch (err) {
      wx.showToast({ title: '获取失败', icon: 'none' });
    }
  },
  goBack() { wx.navigateBack(); }
});
