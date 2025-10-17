<!-- 38f6b1e2-92dd-4ab2-acbe-ce7e01ef9771 33519812-1ad4-4e47-b53f-03f17b9a2b65 -->
# 团队作业展示弹窗实施计划

## 实现概述

在网站首页添加一个液态玻璃（glassmorphism）风格的弹窗，说明这是小组作业展示网站，展示三位成员的邮箱信息，支持中英文切换。弹窗只能通过“Got it/我知道了”按钮关闭（不支持点击遮罩或按 Esc 关闭）。

## 实施步骤

### 1. 多语言文本配置

在国际化资源文件中添加弹窗相关文本：

- 文件: `src/main/resources/i18n/messages.properties` (英文)
- 文件: `src/main/resources/i18n/messages_zh.properties` (中文)
- 添加内容：弹窗标题、说明文字、成员信息、按钮文本（Got it/我知道了）

### 2. 创建液态玻璃风格CSS

创建新的CSS文件专门用于弹窗样式：

- 文件: `src/main/resources/static/css/includes/project-modal.css`
- 实现特性：
- Glassmorphism效果（半透明背景、模糊效果、边框光泽）
- 响应式设计（适配移动端和桌面端）
- 平滑动画过渡
- 现代化的视觉效果（阴影、渐变边框），颜色遵循站点主题色（不使用紫色渐变）

### 3. 创建弹窗JavaScript逻辑

创建新的JavaScript文件处理弹窗行为：

- 文件: `src/main/resources/static/js/includes/project-modal.js`
- 功能实现：
- 页面加载时自动显示弹窗
- 多语言文本动态切换
- 仅“Got it/我知道了”按钮可关闭弹窗
- 禁止点击遮罩或按 Esc 关闭
- 不使用 localStorage（取消“下次不再展示”逻辑）

### 4. 更新header.jsp

在通用header文件中引入新创建的资源：

- 文件: `src/main/webapp/WEB-INF/jsp/includes/header.jsp`
- 添加：
- CSS文件引用（在现有样式表之后）
- JavaScript文件引用（在适当位置）

### 5. 创建弹窗HTML结构

在主要页面模板中添加弹窗HTML：

- 文件: `src/main/webapp/WEB-INF/jsp/includes/header.jsp` 或 `navigation.jsp`
- HTML结构包含：
- 半透明背景遮罩层
- 液态玻璃风格的卡片容器
- 标题区域
- 说明文字区域
- 三位成员邮箱信息横向并排（顺序：OS、FZ、LZ）
- “Got it/我知道了”按钮（无复选框）

## 技术细节

### 液态玻璃效果实现

- `backdrop-filter: blur()` - 背景模糊
- 半透明白色背景 `rgba(255, 255, 255, 0.1)`
- 细腻的边框和阴影
- 颜色遵循站点配色（参考现有样式表），不使用紫色渐变

### 成员信息

1. **OS** — SWE2309200@xmu.edu.my（Osamah Labeed）
2. **FZ** — SWE2309439@xmu.edu.my（Rahmonov Fayzirahmon）
3. **LZ** — SWE2309527@xmu.edu.my（Liu Zhenyu）

### 关闭行为

- 仅通过 “Got it/我知道了” 按钮关闭
- 点击遮罩、按 Esc、点击外部均不关闭
- 不再存储任何“不再显示”标记（不使用 localStorage）

### 多语言支持

- 利用现有的 `window.TravelBlog.Language` 系统，监听语言切换事件并更新弹窗文本

### To-dos

- [ ] 在messages.properties和messages_zh.properties中添加弹窗多语言文本
- [ ] 创建project-modal.css实现液态玻璃风格样式（遵循站点色板，不使用紫色渐变）
- [ ] 创建project-modal.js实现弹窗逻辑（仅按钮关闭；禁用遮罩/Esc；不使用localStorage）
- [ ] 在header.jsp或navigation.jsp中添加弹窗HTML结构（成员横向并排：OS→FZ→LZ；无复选框）
- [ ] 在header.jsp中引入CSS和JS文件


