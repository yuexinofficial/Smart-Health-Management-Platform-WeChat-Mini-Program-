// AI健康答疑逻辑
const api = require('../../utils/api');

Page({
  data: {
    messages: [],
    inputText: '',
    sending: false
  },

  onInput(e) { this.setData({ inputText: e.detail.value }); },

  // 快速提问
  quickAsk(e) {
    const q = e.currentTarget.dataset.q;
    this.setData({ inputText: q });
    this.onSend();
  },

  async onSend() {
    const text = this.data.inputText.trim();
    if (!text || this.data.sending) return;

    const userMsg = { role: 'user', content: text };
    const messages = [...this.data.messages, userMsg];
    this.setData({ messages, inputText: '', sending: true });

    try {
      const res = await api.generateAIResponse(text);
      const aiMsg = { role: 'assistant', content: res.advice || '抱歉，我暂时无法回答这个问题。' };
      this.setData({ messages: [...this.data.messages, aiMsg] });
    } catch (err) {
      const errMsg = { role: 'assistant', content: '抱歉，服务暂时不可用，请稍后再试。' };
      this.setData({ messages: [...this.data.messages, errMsg] });
    } finally {
      this.setData({ sending: false });
      this.scrollToBottom();
    }
  },

  scrollToBottom() {
    setTimeout(() => {
      wx.createSelectorQuery().select('#chat-bottom').boundingClientRect((rect) => {
        if (rect) wx.pageScrollTo({ scrollTop: rect.top + 1000, duration: 300 });
      }).exec();
    }, 100);
  },

  goBack() { wx.navigateBack(); }
});
