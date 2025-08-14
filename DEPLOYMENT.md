# 部署到 GitHub Pages 指南

这个文档说明如何将 Emotion Game（Flutter Web应用）部署到 GitHub Pages。

## 🚀 自动部署（推荐）

项目已经配置了 GitHub Actions 自动部署。每当你推送代码到 `main` 或 `master` 分支时，应用会自动构建并部署到 GitHub Pages。

### 设置步骤：

1. **推送代码到 GitHub**
   ```bash
   git add .
   git commit -m "Add GitHub Pages deployment"
   git push origin main
   ```

2. **启用 GitHub Pages**
   - 在 GitHub 仓库页面，点击 "Settings"
   - 滚动到 "Pages" 部分
   - 在 "Source" 下选择 "GitHub Actions"
   - 保存设置

3. **等待部署完成**
   - 检查 "Actions" 标签页查看部署状态
   - 部署完成后，应用将在 `https://[your-username].github.io/emotion_game/` 可用

## 🛠️ 手动部署

如果你想要手动构建和测试：

### 前提条件
- Flutter SDK (3.24.1 或更高版本)
- Git

### 构建步骤

1. **使用部署脚本**
   ```bash
   ./deploy.sh
   ```

2. **或者手动执行**
   ```bash
   flutter pub get
   flutter analyze
   flutter test
   flutter build web --release --base-href "/emotion_game/"
   ```

## 📁 项目结构

- `.github/workflows/deploy.yml` - GitHub Actions 工作流配置
- `web/` - Web 应用配置文件
- `deploy.sh` - 本地部署脚本
- `build/web/` - 构建输出目录（Git 忽略）

## 🔧 配置说明

### 重要配置文件：

1. **`.github/workflows/deploy.yml`**
   - 自动化 CI/CD 流程
   - 构建 Flutter web 应用
   - 部署到 GitHub Pages

2. **`web/index.html`**
   - 应用的入口点
   - 包含必要的 meta 标签和配置

3. **`web/manifest.json`**
   - PWA 配置
   - 应用图标和主题设置

## 🚨 故障排除

### 常见问题：

1. **构建失败**
   - 检查 Flutter 版本兼容性
   - 确保所有依赖项都正确安装
   - 查看 GitHub Actions 日志获取详细错误信息

2. **页面无法加载**
   - 确认 base-href 设置正确
   - 检查 GitHub Pages 设置是否正确

3. **资源文件找不到**
   - 确认 assets 路径配置正确
   - 检查构建输出中是否包含所有必要文件

### 调试步骤：

1. 在本地运行 `flutter build web --release --base-href "/emotion_game/"`
2. 检查 `build/web/` 目录内容
3. 使用本地服务器测试构建文件
4. 查看浏览器开发者工具的控制台错误

## 📱 支持的平台

- ✅ Chrome/Chromium
- ✅ Firefox
- ✅ Safari
- ✅ Edge
- ✅ 移动浏览器

## 🔄 更新部署

要更新已部署的应用：

1. 提交你的更改
2. 推送到 main/master 分支
3. GitHub Actions 会自动重新部署

```bash
git add .
git commit -m "Update game features"
git push origin main
```

## 📞 支持

如果遇到部署问题，请检查：
- GitHub Actions 工作流日志
- Flutter doctor 输出
- 浏览器开发者工具控制台
