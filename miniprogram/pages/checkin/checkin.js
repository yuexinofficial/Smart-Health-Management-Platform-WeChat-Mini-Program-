// 健康打卡页面逻辑
const api = require('../../utils/api');
const app = getApp();

// 生成唯一 key
let _keyCounter = 0;
function nextKey() { return 'k_' + (++_keyCounter) + '_' + Date.now(); }

// 安全取值：防御微信框架可能传入的 undefined (JS值) 或 "undefined" (字符串)
function safeStr(v) {
  if (v === undefined || v === null || String(v) === 'undefined') return '';
  return String(v);
}

Page({
  data: {
    recordDate: '',
    sports: [],
    foods: [],
    sleepDuration: '',
    sleepQuality: '',
    sleepQualities: ['优秀', '良好', '一般', '差'],
    weight: '',
    // 弹窗
    showSportModal: false,
    showFoodModal: false,
    showSportDuration: false,
    showFoodGrams: false,
    // 搜索
    sportKeyword: '',
    sportResults: [],
    foodKeyword: '',
    foodResults: [],
    // 临时选择
    selectedSport: null,
    selectedFood: null,
    sportDuration: '',
    sportCalorie: 0,
    foodGrams: '',
    foodCalorie: 0,
    saving: false
  },

  onLoad() {
    const today = new Date();
    const dateStr = [
      today.getFullYear(),
      String(today.getMonth() + 1).padStart(2, '0'),
      String(today.getDate()).padStart(2, '0')
    ].join('-');
    this.setData({ recordDate: dateStr });
    this.loadAllData();
    this.checkTodayRecord();
  },

  // 预加载全部运动、食物数据
  async loadAllData() {
    try {
      const [sportsRes, foodsRes] = await Promise.all([
        api.getAllSports(),
        api.getAllFoods()
      ]);
      const allSports = (sportsRes && sportsRes.data) ? sportsRes.data : [];
      const allFoods = (foodsRes && foodsRes.data) ? foodsRes.data : [];
      this.allSports = allSports;
      this.allFoods = allFoods;
      console.log('预加载完成: ' + allSports.length + ' 项运动, ' + allFoods.length + ' 项食物');
    } catch (err) {
      console.log('预加载数据失败:', err);
      this.allSports = [];
      this.allFoods = [];
    }
  },

  async checkTodayRecord() {
    try {
      const phone = app.getPhone();
      const res = await api.checkTodayRecord(phone);
      if (res && res.hasRecord) {
        wx.showModal({
          title: '提示',
          content: '今日已提交过记录，请勿重复提交',
          showCancel: false,
          success: () => wx.navigateBack()
        });
      }
    } catch (err) {
      console.log('检查今日记录失败:', err);
    }
  },

  onDateChange(e) {
    this.setData({ recordDate: e.detail.value });
  },

  // ========== 运动相关 ==========
  showSportSearch() {
    this.setData({ showSportModal: true, sportKeyword: '', sportResults: [] });
  },

  closeSportModal() {
    this.setData({ showSportModal: false, sportKeyword: '', sportResults: [] });
  },

  // ★ 核心改造：本地过滤，无异步，无 setData 干扰 input
  onSportSearch(e) {
    const keyword = safeStr(e.detail.value).trim();
    this.setData({ sportKeyword: keyword });

    if (!keyword) {
      this.setData({ sportResults: [] });
      return;
    }

    // 本地字符串匹配过滤
    const list = (this.allSports || []).filter(s =>
      s.name.includes(keyword)
    );
    this.setData({ sportResults: list });
  },

  selectSport(e) {
    const id = String(e.currentTarget.dataset.id);
    const item = this.data.sportResults.find(r => String(r.sport_id) === id);
    if (!item) return;

    this.setData({
      showSportModal: false,
      showSportDuration: true,
      selectedSport: item,
      sportDuration: '',
      sportCalorie: 0
    });
  },

  closeSportDuration() {
    this.setData({ showSportDuration: false });
  },

  onSportDurationInput(e) {
    const val = safeStr(e.detail.value).replace(/[^0-9]/g, '').slice(0, 3);
    const duration = parseInt(val) || 0;
    const calPerHour = this.data.selectedSport ? (this.data.selectedSport.calorie_per_hour || 0) : 0;
    const calorie = Math.round(calPerHour * duration / 60);
    this.setData({ sportDuration: val, sportCalorie: calorie });
  },

  confirmSport() {
    const { selectedSport, sportDuration, sportCalorie } = this.data;
    if (!selectedSport) { wx.showToast({ title: '请先选择运动项目', icon: 'none' }); return; }
    if (!sportDuration || parseInt(sportDuration) <= 0) { wx.showToast({ title: '请输入运动时长', icon: 'none' }); return; }

    this.setData({
      sports: [...this.data.sports, {
        key: nextKey(),
        name: selectedSport.name,
        duration: parseInt(sportDuration),
        calorie: sportCalorie || 0
      }],
      showSportDuration: false
    });
  },

  removeSport(e) {
    const id = String(e.currentTarget.dataset.id);
    this.setData({ sports: this.data.sports.filter(s => s.key !== id) });
  },

  // ========== 饮食相关 ==========
  showFoodSearch() {
    this.setData({ showFoodModal: true, foodKeyword: '', foodResults: [] });
  },

  closeFoodModal() {
    this.setData({ showFoodModal: false, foodKeyword: '', foodResults: [] });
  },

  // ★ 本地过滤
  onFoodSearch(e) {
    const keyword = safeStr(e.detail.value).trim();
    this.setData({ foodKeyword: keyword });

    if (!keyword) {
      this.setData({ foodResults: [] });
      return;
    }

    const list = (this.allFoods || []).filter(f =>
      f.name.includes(keyword)
    );
    this.setData({ foodResults: list });
  },

  selectFood(e) {
    const id = String(e.currentTarget.dataset.id);
    const item = this.data.foodResults.find(r => String(r.food_id) === id);
    if (!item) return;

    this.setData({
      showFoodModal: false,
      showFoodGrams: true,
      selectedFood: item,
      foodGrams: '',
      foodCalorie: 0
    });
  },

  closeFoodGrams() {
    this.setData({ showFoodGrams: false });
  },

  onFoodGramsInput(e) {
    const val = safeStr(e.detail.value).replace(/[^0-9]/g, '').slice(0, 4);
    const grams = parseInt(val) || 0;
    const calPer100g = this.data.selectedFood ? (this.data.selectedFood.calorie_per_100g || 0) : 0;
    const calorie = Math.round(calPer100g * grams / 100);
    this.setData({ foodGrams: val, foodCalorie: calorie });
  },

  confirmFood() {
    const { selectedFood, foodGrams, foodCalorie } = this.data;
    if (!selectedFood) { wx.showToast({ title: '请先选择食物', icon: 'none' }); return; }
    if (!foodGrams || parseInt(foodGrams) <= 0) { wx.showToast({ title: '请输入食用克数', icon: 'none' }); return; }

    this.setData({
      foods: [...this.data.foods, {
        key: nextKey(),
        name: selectedFood.name,
        grams: parseInt(foodGrams),
        calorie: foodCalorie || 0,
        calorie_per_100g: selectedFood.calorie_per_100g || 0
      }],
      showFoodGrams: false
    });
  },

  removeFood(e) {
    const id = String(e.currentTarget.dataset.id);
    this.setData({ foods: this.data.foods.filter(f => f.key !== id) });
  },

  // ========== 睡眠相关 ==========
  onSleepDurationInput(e) {
    const val = safeStr(e.detail.value).replace(/[^0-9.]/g, '');
    const parts = val.split('.');
    const clean = parts.length > 2 ? parts[0] + '.' + parts.slice(1).join('') : val;
    this.setData({ sleepDuration: clean.slice(0, 4) });
  },

  onSleepQualityChange(e) {
    this.setData({ sleepQuality: this.data.sleepQualities[e.detail.value] });
  },

  // ========== 体重相关 ==========
  onWeightInput(e) {
    const val = safeStr(e.detail.value).replace(/[^0-9.]/g, '');
    const parts = val.split('.');
    const clean = parts.length > 2 ? parts[0] + '.' + parts.slice(1).join('') : val;
    this.setData({ weight: clean.slice(0, 5) });
  },

  // ========== 保存 ==========
  async onSave() {
    const { sports, foods, sleepDuration, weight, recordDate } = this.data;

    if (sports.length === 0) { wx.showToast({ title: '请添加运动记录', icon: 'none' }); return; }
    if (foods.length === 0) { wx.showToast({ title: '请添加饮食记录', icon: 'none' }); return; }
    if (!sleepDuration || parseFloat(sleepDuration) <= 0) { wx.showToast({ title: '请输入睡眠时长', icon: 'none' }); return; }
    if (!weight || parseFloat(weight) <= 0) { wx.showToast({ title: '请输入体重', icon: 'none' }); return; }

    this.setData({ saving: true });

    try {
      const res = await api.saveSportRecord({
        phone: app.getPhone(),
        date: recordDate,
        sports: sports.map(s => ({ name: s.name, duration: s.duration, calorie: s.calorie })),
        foods: foods.map(f => ({ name: f.name, grams: f.grams, calorie: f.calorie })),
        sleep: { duration: parseFloat(sleepDuration), quality: this.data.sleepQuality || '未记录' },
        weight: parseFloat(weight)
      });

      if (res && res.success) {
        wx.showToast({ title: '保存成功', icon: 'success' });
        setTimeout(() => wx.navigateBack(), 1000);
      } else {
        wx.showToast({ title: (res && res.message) || '保存失败', icon: 'none' });
      }
    } catch (err) {
      wx.showToast({ title: (err && err.message) || '保存失败', icon: 'none' });
    } finally {
      this.setData({ saving: false });
    }
  },

  goBack() {
    wx.navigateBack();
  }
});
