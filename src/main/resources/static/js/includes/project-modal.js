/**
 * Project Modal - Unified Logic
 * 
 * 功能说明：
 * 1. 每次访问网站（新session）自动弹出一次
 * 2. 同一session内页面跳转不再显示
 * 3. 用户勾选"不再显示"后，永久不显示（localStorage）
 * 4. 只能通过按钮关闭，不能通过ESC或点击遮罩关闭
 * 
 * Display Rules:
 * 1. Show once per browser session automatically
 * 2. Don't show again when navigating between pages in same session
 * 3. If user checks "Don't show again", never show (stored in localStorage)
 * 4. Only closable via button, not via ESC or overlay click
 */
(function() {
  'use strict';

  // 存储键名 / Storage keys
  var STORAGE_KEY_PERMANENT = 'hideProjectModal';        // localStorage: 永久隐藏
  var STORAGE_KEY_SESSION = 'projectModalShownThisSession'; // sessionStorage: 本次session已显示
  var MODAL_DELAY = 800; // 延迟显示时间（ms）/ Delay before showing (ms)

  /**
   * 项目弹窗管理器 / Project Modal Manager
   */
  function ProjectModal() {
    this.overlay = null;
    this.modal = null;
    this.button = null;
    this.checkbox = null;
    this.initialized = false;
  }

  /**
   * 初始化 / Initialize
   */
  ProjectModal.prototype.init = function() {
    if (this.initialized) return;
    
    // 检查是否应该永久隐藏 / Check if should hide permanently
    if (this.shouldHidePermanently()) {
      console.log('Project modal: Hidden permanently by user preference');
      return;
    }

    // 检查本次session是否已显示 / Check if already shown this session
    if (this.hasShownThisSession()) {
      console.log('Project modal: Already shown this session');
      return;
    }

    var self = this;
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', function() { self.setup(); });
    } else {
      self.setup();
    }
    
    this.initialized = true;
  };

  /**
   * 设置DOM元素和事件 / Setup DOM elements and events
   */
  ProjectModal.prototype.setup = function() {
    this.overlay = document.getElementById('projectModalOverlay');
    this.modal = document.getElementById('projectModal');
    this.button = document.getElementById('projectModalButton');
    this.checkbox = document.getElementById('projectModalCheckbox');

    if (!this.overlay || !this.modal || !this.button) {
      console.error('Project modal: Required elements not found');
      return;
    }

    this.bindEvents();
    
    // 延迟显示弹窗 / Show modal after delay
    var self = this;
    setTimeout(function() { 
      self.show(); 
      // 标记本次session已显示 / Mark as shown for this session
      self.markShownThisSession();
    }, MODAL_DELAY);
  };

  /**
   * 绑定事件 / Bind events
   */
  ProjectModal.prototype.bindEvents = function() {
    var self = this;
    
    // 按钮点击关闭 / Close on button click
    this.button.addEventListener('click', function(e) {
      e.preventDefault();
      self.close();
    });

    // 阻止通过点击遮罩关闭 / Prevent closing via overlay click
    this.overlay.addEventListener('click', function(e) {
      if (e.target === self.overlay) {
        e.stopPropagation();
        // 添加轻微抖动效果提示用户 / Add shake effect to hint user
        if (self.modal) {
          self.modal.style.animation = 'none';
          setTimeout(function() {
            self.modal.style.animation = 'modalShake 0.3s ease';
          }, 10);
        }
      }
    }, true);

    // 阻止通过ESC关闭 / Prevent closing via ESC key
    document.addEventListener('keydown', function(e) {
      if (self.overlay && self.overlay.classList.contains('show')) {
        if (e.key === 'Escape' || e.key === 'Esc') {
          e.preventDefault();
          e.stopPropagation();
          // 添加轻微抖动效果提示用户 / Add shake effect to hint user
          if (self.modal) {
            self.modal.style.animation = 'none';
            setTimeout(function() {
              self.modal.style.animation = 'modalShake 0.3s ease';
            }, 10);
          }
        }
      }
    }, true);

    // 阻止modal内部点击冒泡 / Stop propagation for clicks inside modal
    this.modal.addEventListener('click', function(e) {
      e.stopPropagation();
    });

    // 监听语言切换事件 / Listen for language change events
    document.addEventListener('languageChanged', function() {
      if (window.I18n && typeof window.I18n.apply === 'function') {
        window.I18n.apply(self.modal);
      }
    });
  };

  /**
   * 显示弹窗 / Show modal
   */
  ProjectModal.prototype.show = function() {
    if (!this.overlay) return;
    
    this.overlay.classList.add('show');
    this.overlay.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden'; // 禁止背景滚动 / Disable body scroll
    
    // 聚焦到按钮以便键盘操作 / Focus button for keyboard accessibility
    if (this.button) {
      var self = this;
      setTimeout(function() { 
        try { self.button.focus(); } catch(e) {} 
      }, 100);
    }
    
    console.log('Project modal: Shown');
  };

  /**
   * 关闭弹窗 / Close modal
   */
  ProjectModal.prototype.close = function() {
    if (!this.overlay) return;
    
    // 如果勾选了"不再显示"，保存到localStorage / Save to localStorage if "don't show again" is checked
    if (this.checkbox && this.checkbox.checked) {
      try {
        localStorage.setItem(STORAGE_KEY_PERMANENT, 'true');
        console.log('Project modal: Set to never show again');
      } catch (e) {
        console.error('Project modal: Failed to save preference', e);
      }
    }
    
    this.overlay.classList.remove('show');
    this.overlay.setAttribute('aria-hidden', 'true');
    document.body.style.overflow = ''; // 恢复背景滚动 / Restore body scroll
    
    console.log('Project modal: Closed');
  };

  /**
   * 检查是否应该永久隐藏 / Check if should hide permanently
   */
  ProjectModal.prototype.shouldHidePermanently = function() {
    try {
      return localStorage.getItem(STORAGE_KEY_PERMANENT) === 'true';
    } catch (e) {
      return false;
    }
  };

  /**
   * 检查本次session是否已显示 / Check if already shown this session
   */
  ProjectModal.prototype.hasShownThisSession = function() {
    try {
      return sessionStorage.getItem(STORAGE_KEY_SESSION) === 'true';
    } catch (e) {
      return false;
    }
  };

  /**
   * 标记本次session已显示 / Mark as shown for this session
   */
  ProjectModal.prototype.markShownThisSession = function() {
    try {
      sessionStorage.setItem(STORAGE_KEY_SESSION, 'true');
    } catch (e) {
      console.error('Project modal: Failed to mark session', e);
    }
  };

  // 创建全局实例并初始化 / Create global instance and initialize
  window.ProjectModal = new ProjectModal();
  window.ProjectModal.init();

})();

/**
 * 添加抖动动画CSS / Add shake animation CSS
 * (如果CSS文件中没有，这里通过JS注入) / Inject via JS if not in CSS file
 */
(function() {
  var styleId = 'project-modal-shake-animation';
  if (!document.getElementById(styleId)) {
    var style = document.createElement('style');
    style.id = styleId;
    style.textContent = `
      @keyframes modalShake {
        0%, 100% { transform: scale(1) translateY(0) translateX(0); }
        25% { transform: scale(1) translateY(0) translateX(-8px); }
        75% { transform: scale(1) translateY(0) translateX(8px); }
      }
    `;
    document.head.appendChild(style);
  }
})();
