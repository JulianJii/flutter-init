---
title: 首页
---

# Flutter Riverpod Clean Architecture 模板

基于 Riverpod 3 + Clean Architecture 的 Flutter 起步模板：`domain / data / presentation / providers` 四层、`fpdart` 的 `Either<Failure, T>` 错误处理、`@riverpod` 代码生成、gen-l10n 强类型本地化、扁平 `GoRouter`。

> 骨架是完整的——架构、分层、DI、测试与 CI 都能跑；各 feature 的业务数据源目前是**模拟实现**（延时后返回假数据，真实 API 调用被注释），接后端时替换 `lib/features/*/data/datasources/` 即可，上层不用改。哪些是 stub、哪些是真能力，见[核心功能](./FEATURES.md)。

## 快速开始

```bash
git clone https://github.com/JulianJii/init.git
cd init
flutter pub get
flutter run
```

生成物已入库，克隆后无需先跑 build_runner。之后只在改了注解或文案时才需要：

```bash
dart run build_runner build --delete-conflicting-outputs   # 改了 @riverpod / @JsonSerializable
flutter gen-l10n                                           # 改了 ARB
flutter analyze && flutter test                            # 提交前必须全绿
```

## 文档

| 主题 | 内容 |
|---|---|
| [快速开始](./GETTING_STARTED.md) | 环境要求、安装、运行 |
| [架构指南](./ARCHITECTURE_GUIDE.md) | 四层依赖规则、DI 接线、测试策略 |
| [编码规范](./CODING_STANDARDS.md) | 必须 / 禁止清单 |
| [核心功能](./FEATURES.md) | 每个能力的真实状态（含 stub 标注） |
| [工具与脚本](./TOOLS.md) | feature / 语言 / 图标生成、测试运行器 |
| [本地化](./LOCALIZATION_GUIDE.md) | ARB、gen-l10n、语言资源 |
| [图片处理](./IMAGE_HANDLING_GUIDE.md) | `AdvancedImage`、特效、缓存现状 |
| [生物识别](./BIOMETRIC_AUTH_GUIDE.md) | `local_auth` 封装与调试开关 |
| [功能开关](./FEATURE_FLAGS_GUIDE.md) | `featureFlagProvider` |
| [分析埋点](./ANALYTICS_GUIDE.md) | `analyticsProvider`（stub） |
| [离线架构](./OFFLINE_ARCHITECTURE_GUIDE.md) | 离线优先的设计形态（未接线） |
| [CI/CD](./CICD_GUIDE.md) | 三个 GitHub Actions 工作流与密钥 |
| [示例代码](./EXAMPLES.md) | 旧示例，部分 API 已过期 |

## 许可证

MIT，详见 [LICENSE](https://github.com/JulianJii/init/blob/main/LICENSE)。
