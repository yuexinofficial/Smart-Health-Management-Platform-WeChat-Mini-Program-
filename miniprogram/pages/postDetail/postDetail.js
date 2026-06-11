const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    postId: '',
    post: null,
    comments: [],
    commentText: '',
    showMenu: false,
    selectedComment: null,
    canDelete: false
  },

  onLoad(options) {
    if (options.postId) {
      this.setData({ postId: options.postId });
      this.loadPostDetail();
      this.loadComments();
    }
  },

  async loadPostDetail() {
    try {
      const phone = app.getPhone();
      const res = await api.getPostDetail(this.data.postId, phone);
      if (res.success) {
        const post = res.post;
        post.avatar_url = app.getFullUrl(post.avatar_url);
        this.setData({ post: post });
      }
    } catch (err) {
      wx.showToast({ title: '加载帖子失败', icon: 'none' });
    }
  },

  async loadComments() {
    try {
      const res = await api.getComments(this.data.postId);
      if (res.success) {
        this.setData({ comments: res.comments || [] });
      }
    } catch (err) {
      console.log('加载评论失败:', err);
    }
  },

  // 点赞切换
  async onToggleLike() {
    const { post } = this.data;
    const phone = app.getPhone();
    const isLike = !post.is_liked;

    // 乐观更新UI
    this.setData({
      'post.is_liked': isLike,
      'post.like_count': isLike ? post.like_count + 1 : Math.max(0, post.like_count - 1)
    });

    try {
      await api.toggleLike(this.data.postId, phone, isLike);
    } catch (err) {
      // 失败时恢复
      this.setData({
        'post.is_liked': !isLike,
        'post.like_count': post.like_count
      });
      wx.showToast({ title: '操作失败', icon: 'none' });
    }
  },

  // 评论输入
  onCommentInput(e) {
    this.setData({ commentText: e.detail.value });
  },

  // 提交评论
  async onSubmitComment() {
    const text = this.data.commentText.trim();
    if (!text) {
      wx.showToast({ title: '请输入评论内容', icon: 'none' });
      return;
    }

    try {
      const phone = app.getPhone();
      await api.createComment(this.data.postId, phone, text);
      this.setData({ commentText: '' });
      wx.showToast({ title: '评论成功', icon: 'success' });
      // 重新加载评论和帖子详情
      this.loadComments();
      setTimeout(() => this.loadPostDetail(), 300);
    } catch (err) {
      wx.showToast({ title: '评论失败', icon: 'none' });
    }
  },

  // 显示评论操作菜单
  showCommentMenu(e) {
    const item = e.currentTarget.dataset.item;
    const phone = app.getPhone();
    this.setData({
      showMenu: true,
      selectedComment: item,
      canDelete: item.phone === phone
    });
  },

  closeMenu() {
    this.setData({ showMenu: false, selectedComment: null });
  },

  // 删除评论
  async onDeleteComment() {
    const comment = this.data.selectedComment;
    if (!comment) return;

    wx.showModal({
      title: '确认删除',
      content: '确定要删除这条评论吗？',
      success: async (res) => {
        if (res.confirm) {
          try {
            await api.deleteComment(comment.comment_id);
            wx.showToast({ title: '删除成功', icon: 'success' });
            this.closeMenu();
            this.loadComments();
            setTimeout(() => this.loadPostDetail(), 300);
          } catch (err) {
            wx.showToast({ title: '删除失败', icon: 'none' });
          }
        }
      }
    });
  },

  // 复制评论
  onCopyComment() {
    const comment = this.data.selectedComment;
    if (comment) {
      wx.setClipboardData({
        data: comment.comment_content,
        success: () => {
          wx.showToast({ title: '已复制', icon: 'success' });
        }
      });
    }
    this.closeMenu();
  },

  goBack() {
    wx.navigateBack();
  }
});
