const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    adviceText: '',
    isPlan: false,
    loadingAdvice: false,
    loadingPlan: false
  },

  // 获取专业健康建议
  async getHealthAdvice() {
    this.setData({ loadingAdvice: true, isPlan: false, adviceText: '' });
    try {
      const res = await api.getHealthAdvice(app.getPhone());
      this.setData({ adviceText: res.advice || '暂无建议数据' });
    } catch (err) {
      wx.showToast({ title: '获取失败，请稍后再试', icon: 'none' });
    } finally {
      this.setData({ loadingAdvice: false });
    }
  },

  // 生成今日健康计划
  async getDailyPlan() {
    this.setData({ loadingPlan: true, isPlan: true, adviceText: '' });
    try {
      const res = await api.getDailyPlan(app.getPhone());
      this.setData({ adviceText: res.plan || '暂无计划数据' });
    } catch (err) {
      wx.showToast({ title: '生成失败，请稍后再试', icon: 'none' });
    } finally {
      this.setData({ loadingPlan: false });
    }
  },

  goBack() { wx.navigateBack(); }
});
