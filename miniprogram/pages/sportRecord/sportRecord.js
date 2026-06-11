const api = require('../../utils/api');
const app = getApp();

Page({
  data: { startDate: '', endDate: '', records: [] },
  onLoad() {
    const today = new Date();
    const thirtyDaysAgo = new Date(today.getTime() - 30 * 24 * 60 * 60 * 1000);
    this.setData({
      startDate: this.formatDate(thirtyDaysAgo),
      endDate: this.formatDate(today)
    });
    this.loadRecords();
  },
  formatDate(d) {
    return `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}-${String(d.getDate()).padStart(2,'0')}`;
  },
  onStartDateChange(e) { this.setData({ startDate: e.detail.value }); },
  onEndDateChange(e) { this.setData({ endDate: e.detail.value }); },
  async onSearch() { await this.loadRecords(); },
  async loadRecords() {
    try {
      const res = await api.getSportRecords(app.getPhone(), this.data.startDate, this.data.endDate);
      if (res.success) this.setData({ records: res.records || [] });
    } catch (err) {
      wx.showToast({ title: '获取失败', icon: 'none' });
    }
  },
  goBack() { wx.navigateBack(); }
});
