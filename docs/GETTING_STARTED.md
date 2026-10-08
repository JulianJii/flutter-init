# Flutter Riverpod Clean Architecture 入门指南

本指南将帮助你快速上手 Flutter Riverpod Clean Architecture 模板。

## 环境要求

- Flutter SDK（`pubspec.yaml` 中固定为 3.47.5）
- Dart SDK（`>=3.11.0 <4.0.0`）
- 支持 Flutter 的 IDE（VS Code、Android Studio 或 IntelliJ）

## 安装方式

### 方式一：克隆仓库

```bash
git clone https://github.com/JulianJii/init.git
cd init
flutter pub get
```

### 方式二：作为 GitHub 模板创建新项目

1. 前往 [GitHub 仓库](https://github.com/JulianJii/init)
2. 点击「Use this template」创建新仓库
3. 克隆新仓库到本地
4. 运行 `flutter pub get` 安装依赖

> 生成物（`*.g.dart`、`lib/gen/**`、`lib/l10n/gen/**`）**已入库**，克隆后无需先跑 build_runner。
> 之后只要改了 `@riverpod` / `@JsonSerializable` 注解或 ARB 文件，才需要
> `dart run build_runner build --delete-conflicting-outputs` / `flutter gen-l10n`。

## 运行项目

安装完成后，运行以下命令启动应用：

```bash
flutter run
```

这将在已连接的设备或模拟器上启动应用。

## 下一步

- 阅读 [架构指南](./architecture.html)，理解 domain / data / presentation / providers 四层
- 阅读 [编码规范](./coding_standards.html)，再动手写代码
- 浏览 `lib/examples/` 里的示例页面（主题、本地化、集成能力 demo）
- 仓库根目录的 `AGENTS.md` 是 AI 速查表，但**未入库**（`.gitignore`）——新克隆的仓库里没有它，规则看上面两篇文档与源码
