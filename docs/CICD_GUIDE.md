# CI/CD 配置指南

本指南介绍如何使用 Flutter Riverpod Clean Architecture 模板中的 CI/CD 配置来自动化构建、测试和部署流程。

## 目录

- [简介](#introduction)
- [GitHub Actions 配置](#github-actions-configuration)
- [Fastlane 集成](#fastlane-integration)
- [环境变量和密钥](#environment-variables-and-secrets)
- [手动部署](#manual-deployment)
- [环境特定配置](#environment-specific-configuration)
- [最佳实践](#best-practices)

## 简介

持续集成和持续部署（CI/CD）自动化了应用的构建、测试和部署过程。该模板包含：

- GitHub Actions 工作流用于 CI/CD
- Fastlane 配置用于简化部署
- 环境特定的配置
- 密钥管理

## GitHub Actions 配置

该模板包含位于 `.github/workflows/` 目录下的 GitHub Actions 工作流文件：

| 工作流 | 触发条件 | 实际执行的步骤 |
|---|---|---|
| `flutter_ci.yml` | push / PR 到 `main` | `flutter pub get` → `flutter analyze` → `flutter test`（真实有效） |
| `docs.yml` | push 到 `main` 且改动 `docs/**`，或手动触发 | 用 Python 执行 `docs/build_site.py`，上传 artifact 并部署 GitHub Pages |
| `flutter_ci_cd.yml` | push 到 `main`、`v*` tag，或手动触发 | 按 pubspec 版本打 tag → 构建 Android APK（`--split-per-abi`）与 Windows x64，并发布到对应 GitHub Release |

### 静态分析 / 测试 / 构建 / 部署

真正生效的检查是 `flutter_ci.yml`（analyze + test）。`flutter_ci_cd.yml` 负责构建与发布：Android job 先创建 Release 并上传 APK，Windows job 依赖它，再把 `init-windows-x64.zip` 挂到同一个 Release 上。iOS 构建未配置。

## Fastlane 集成

> **注意**：当前项目仅包含基本的 `fastlane/Fastfile` 配置。完整的 Fastlane 设置（包括 `Gemfile`、`Appfile` 和平台特定目录）待后续添加。

### Android 命令

```bash
# Build for development
fastlane android build env:development

# Build for production
fastlane android build env:production

# Deploy to Google Play internal track
fastlane android deploy env:production track:internal

# Deploy to Google Play production
fastlane android deploy env:production track:production
```

### iOS 命令

```bash
# Build for development
fastlane ios build env:development

# Build for production
fastlane ios build env:production

# Deploy to TestFlight
fastlane ios deploy env:production
```

## 环境变量和密钥

### 必需的密钥（GitHub）

在 GitHub 仓库设置中添加以下密钥：

#### Android
- `ANDROID_KEYSTORE_BASE64`: Base64-encoded Android keystore
- `ANDROID_KEYSTORE_PASSWORD`: Keystore password
- `ANDROID_KEY_ALIAS`: Key alias
- `ANDROID_KEY_PASSWORD`: Key password
- `PLAY_STORE_JSON_KEY`: Google Play service account JSON key

#### iOS
- `APPLE_ID`: Apple ID email
- `APP_SPECIFIC_PASSWORD`: App-specific password
- `TEAM_ID`: Apple developer team ID


## 手动部署

### 首次设置 Fastlane

```bash
# Install Fastlane
gem install fastlane

# For Android, set up Google Play credentials
fastlane supply init

# For iOS, set up App Store Connect credentials
fastlane pilot init
```

### Android 手动部署

```bash
cd android
fastlane android deploy env:production track:internal
```

### iOS 手动部署

```bash
cd ios
fastlane ios deploy env:production
```

## 环境特定配置

### Flutter 环境配置

> **注意**：当前项目**不使用 flavor 系统**，所有环境共享单个 `lib/main.dart` 入口（Android/iOS 工程与 CI 中均无 `productFlavors` / `--flavor`）。多环境目前仅体现在 Fastlane 读取 `.env.<env>` 的流程上，Dart 侧尚未接入。

## 最佳实践

1. **绝不提交密钥**：始终使用环境变量或密钥管理
2. **将 CI/CD 配置纳入版本控制**：将工作流文件纳入版本控制
3. **部署前先测试**：确保所有测试通过后再部署
4. **使用 feature flags**：将部署与功能发布解耦
5. **语义化版本**：使用正确的版本号规范（MAJOR.MINOR.PATCH）
6. **自动化一切**：避免部署过程中的手动步骤
7. **监控发布**：部署后跟踪崩溃和问题
8. **保持构建快速**：优化并缓存依赖
9. **编写发布说明**：为用户记录变更
10. **规划回滚方案**：准备回退到之前版本的策略

通过遵循这些实践，你可以构建一个强大的 CI/CD 流水线，简化开发流程并降低生产环境中的错误风险。
