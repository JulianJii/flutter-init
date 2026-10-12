# CI/CD 配置指南

本指南介绍如何使用 Flutter Riverpod Clean Architecture 模板中的 CI/CD 配置来自动化构建、测试和部署流程。

## 简介

持续集成和持续部署（CI/CD）自动化了构建、测试与发布流程。本模板包含三个 GitHub Actions 工作流（见下表）；`fastlane/` 目前只有骨架，CI 不经过它。

## GitHub Actions 配置

该模板包含位于 `.github/workflows/` 目录下的 GitHub Actions 工作流文件：

| 工作流 | 触发条件 | 实际执行的步骤 |
|---|---|---|
| `flutter_ci.yml` | push / PR 到 `main` | `flutter pub get` → `flutter analyze` → `flutter test`（真实有效） |
| `docs.yml` | push 到 `main` 且改动 `docs/**`，或手动触发 | 用 Python 执行 `docs/build_site.py`，上传 artifact 并部署 GitHub Pages |
| `flutter_ci_cd.yml` | push 到 `main`、`v*` tag，或手动触发 | 按 pubspec 版本打 tag → 构建 Android APK（`--split-per-abi`）与 Windows x64，并发布到对应 GitHub Release |

### 静态分析 / 测试 / 构建 / 部署

真正生效的检查是 `flutter_ci.yml`（analyze + test）。`flutter_ci_cd.yml` 负责构建与发布：Android job 先创建 Release 并上传 APK，Windows job 依赖它，再把 `init-windows-x64.zip` 挂到同一个 Release 上。iOS 构建未配置。

## Fastlane

仓库里只有 `fastlane/Fastfile` 这个骨架：**没有** `Gemfile`、`Appfile`、平台目录，**CI 也不经过 Fastlane**（工作流直接跑 `flutter build apk`）。`Fastfile` 读的是 `.env.<env>`（`fastlane/README` 里有用法），但 Dart 侧不读 `.env`。

## 环境变量和密钥

`flutter_ci_cd.yml` 的 Android job 需要以下 4 个 secret，缺任何一个签名都会失败：

- `ANDROID_KEYSTORE_BASE64`：keystore 文件的 Base64
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

`PLAY_STORE_JSON_KEY`、`APPLE_ID`、`APP_SPECIFIC_PASSWORD`、`TEAM_ID` 只有 Fastlane 发布流程才用得到，
而 Fastlane 尚未接线——现在配上也不会被 CI 读取。Windows job 不需要 secret。

## 环境特定配置

### Flutter 环境配置

> **注意**：当前项目**不使用 flavor 系统**，所有环境共享单个 `lib/main.dart` 入口（Android/iOS 工程与 CI 中均无 `productFlavors` / `--flavor`）。多环境目前仅体现在 Fastlane 读取 `.env.<env>` 的流程上，Dart 侧尚未接入。

## 注意事项

- 密钥只放 GitHub Secrets，不要提交 keystore 或 `.env.*`。
- 版本号取自 `pubspec.yaml`，打 `v*` tag 才会触发发布。
- 发布前确认 `flutter_ci.yml` 的 analyze + test 是绿的。
