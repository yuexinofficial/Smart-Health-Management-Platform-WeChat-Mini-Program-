const api = require('../../utils/api');

Page({
  data: { ranking: [], maxCount: 1 },
  onLoad() { this.loadRanking(); },
  async loadRanking() {
    try {
      const res = await api.getSportRanking();
      if (res.data && res.data.length > 0) {
        const maxCount = Math.max(...res.data.map(r => r.frequency));
        this.setData({ ranking: res.data, maxCount: maxCount || 1 });
      }
    } catch (err) {
      console.log('获取排行失败:', err);
    }
  },
  goBack() { wx.navigateBack(); }
});
