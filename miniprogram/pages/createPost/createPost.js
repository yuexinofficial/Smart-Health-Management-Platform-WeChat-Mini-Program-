const api = require('../../utils/api');
const app = getApp();

Page({
  data: {
    topic: '',
    content: '',
    imagePath: '',
    publishing: false
  },

  onTopicInput(e) { this.setData({ topic: e.detail.value }); },
  onContentInput(e) { this.setData({ content: e.detail.value }); },

  // 选择图片
  chooseImage() {
    wx.chooseMedia({
      count: 1,
      mediaType: ['image'],
      sizeType: ['compressed'],
      sourceType: ['album', 'camera'],
      success: (res) => {
        this.setData({ imagePath: res.tempFiles[0].tempFilePath });
      }
    });
  },

  // 预览图片
  previewImage() {
    wx.previewImage({ urls: [this.data.imagePath] });
  },

  // 删除图片
  deleteImage() {
    this.setData({ imagePath: '' });
  },

  // 发布帖子
  async onPublish() {
    const { topic, content, imagePath } = this.data;
    const phone = app.getPhone();

    if (!topic.trim()) {
      wx.showToast({ title: '请输入帖子主题', icon: 'none' });
      return;
    }
    if (!content.trim()) {
      wx.showToast({ title: '请输入帖子内容', icon: 'none' });
      return;
    }

    this.setData({ publishing: true });

    try {
      await api.createPost({
        phone,
        topic: topic.trim(),
        content: content.trim(),
        image_path: imagePath || ''
      });

      wx.showToast({ title: '发布成功', icon: 'success' });
      setTimeout(() => {
        wx.navigateBack();
      }, 1000);
    } catch (err) {
      wx.showToast({ title: '发布失败,请重试', icon: 'none' });
    } finally {
      this.setData({ publishing: false });
    }
  },

  goBack() { wx.navigateBack(); }
});
