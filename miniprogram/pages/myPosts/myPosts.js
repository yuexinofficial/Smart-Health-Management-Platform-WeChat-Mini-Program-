const api = require('../../utils/api');
const app = getApp();

Page({
  data: { posts: [], isManaging: false },

  onShow() { this.loadPosts(); },

  async loadPosts() {
    try {
      const res = await api.getMyPosts(app.getPhone());
      if (res.success) this.setData({ posts: res.posts || [] });
    } catch (err) {
      wx.showToast({ title: '加载失败', icon: 'none' });
    }
  },

  toggleManage() {
    this.setData({ isManaging: !this.data.isManaging });
  },

  async onDeletePost(e) {
    const postId = e.currentTarget.dataset.id;
    wx.showModal({
      title: '确认删除',
      content: '确定要删除这篇帖子吗？删除后不可恢复。',
      success: async (res) => {
        if (res.confirm) {
          try {
            await api.deletePost(postId);
            wx.showToast({ title: '删除成功', icon: 'success' });
            this.loadPosts();
          } catch (err) {
            wx.showToast({ title: '删除失败', icon: 'none' });
          }
        }
      }
    });
  },

  goBack() { wx.navigateBack(); }
});
