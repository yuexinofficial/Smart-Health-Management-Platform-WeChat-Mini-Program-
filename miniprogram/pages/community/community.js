// 社区页面逻辑
const api = require('../../utils/api');

Page({
  data: {
    searchQuery: '',
    posts: [],
    page: 1,
    pageSize: 10,
    hasMore: true,
    loading: false,
    loadingMore: false
  },

  onShow() {
    this.setData({ page: 1, posts: [], hasMore: true });
    this.loadPosts();
  },

  onSearchInput(e) { this.setData({ searchQuery: e.detail.value }); },

  onSearch() {
    this.setData({ page: 1, posts: [], hasMore: true });
    this.loadPosts();
  },

  async loadPosts() {
    if (this.data.loading) return;
    this.setData({ loading: true });
    try {
      const res = await api.getPosts(this.data.searchQuery, this.data.page, this.data.pageSize);
      if (res.success) {
        const newPosts = res.posts || [];
        this.setData({
          posts: this.data.page === 1 ? newPosts : [...this.data.posts, ...newPosts],
          hasMore: newPosts.length >= this.data.pageSize
        });
      }
    } catch (err) {
      wx.showToast({ title: '加载失败', icon: 'none' });
    } finally {
      this.setData({ loading: false, loadingMore: false });
    }
  },

  loadMore() {
    if (this.data.loadingMore || !this.data.hasMore) return;
    this.setData({ page: this.data.page + 1, loadingMore: true }, () => { this.loadPosts(); });
  },

  goToDetail(e) {
    wx.navigateTo({ url: `/pages/postDetail/postDetail?postId=${e.currentTarget.dataset.id}` });
  },

  goToCreatePost() {
    wx.navigateTo({ url: '/pages/createPost/createPost' });
  }
});
