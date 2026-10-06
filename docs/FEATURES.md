---
title: Features
---

# 核心功能

本文档详细介绍了 Flutter Riverpod Clean Architecture 模板中的核心功能。

## 🚀 展示功能（新增！）

### 实时聊天（WebSocket）
基于 WebSocket 的聊天应用完整实现。
- **访问方式**：`Ref -> ChatProvider`
- **架构**：领域层中的 `Stream<Message>`
- **技术**：`web_socket_channel`，乐观 UI 更新
- **路径**：`lib/features/chat/`

### 复杂表单问卷
支持验证和条件逻辑的高级表单处理。
- **技术**：`flutter_form_builder`
- **功能**：
  - 异步验证（例如，用户名可用性检查）
  - 条件字段（依赖于前序答案）
  - 自定义表单输入
- **路径**：`lib/features/survey/`

---

## 分析集成

通过灵活的分析系统追踪用户交互和应用性能：

```dart
// Access analytics
final analytics = ref.watch(analyticsProvider);

// Log screen views
analytics.logScreenView('HomeScreen', parameters: {'referrer': 'deeplink'});

// Log user actions
analytics.logUserAction(
  action: 'button_tap',
  category: 'engagement',
  label: 'sign_up_button',
);
```

详情请参见[分析指南](https://jessejii.github.io/init/analytics.html)。

## 推送通知

> **现状**：接口定义完整（权限申请、本地通知、深链、主题订阅），但当前唯一实现是 `DebugNotificationService`（全部 `debugPrint` 模拟），**未接入 FCM / flutter_local_notifications**，不要当作可用的推送能力。

```dart
// Access notification service
final service = ref.watch(notificationServiceProvider);

// Request permission
final status = await service.requestPermission();

// Show a local notification
await service.showLocalNotification(
  id: 'msg-123',
  title: 'New message',
  body: 'You received a new message from John',
  action: '/chat/john',
  channel: 'messages',
);
```

## 生物识别认证

安全的指纹和人脸识别，用于保护敏感操作：

```dart
// Access biometric authentication
final biometricAuth = ref.watch(biometricAuthControllerProvider);

// Authenticate the user
if (isAvailable) {
  final result = await biometricAuth.authenticate(
    reason: 'Please authenticate to access your account',
    authReason: AuthReason.appAccess,
  );
}
```

详情请参见[生物识别认证指南](https://jessejii.github.io/init/biometric_auth.html)。

## 功能开关

用于 A/B 测试和分阶段发布的运行时功能开关：

```dart
// 声明式读取（推荐）
final enabled = ref.watch(
  featureFlagProvider('premium_features', defaultValue: false),
);

// 或用 FeatureFlag widget 包裹（注意参数名是 featureKey）
FeatureFlag(
  featureKey: 'premium_features',
  child: const PremiumSection(),
)
```

详情请参见[功能开关指南](https://jessejii.github.io/init/feature_flags.html)。

## 高级图片处理

提供特效（灰度/褐色/模糊等，`ImageTransformer`）、Shimmer 占位图（`ShimmerPlaceholder`）与按语言选择资源的 `LocalizedImage`。

> **现状**：`AdvancedImage` 未消费内存缓存、加载是模拟延迟；`SvgImage`/`SvgRenderer` 是占位渲染器（无 `flutter_svg` 依赖）；`imageProcessorProvider` 是 no-op 的 Debug 实现。仅特效与占位图可直接使用。

详情请参见[图片处理指南](https://jessejii.github.io/init/image_handling.html)。

## 多语言支持

内置国际化，轻松切换语言：

```dart
// Access translated text
Text(AppLocalizations.of(context).welcome_message);
```

详情请参见[本地化指南](https://jessejii.github.io/init/localization.html)。

## 内存缓存

`lib/core/storage/cache_manager.dart` 提供带 LRU 淘汰的**纯内存**缓存 `CacheManager<T>`（无磁盘层；`lib/core/storage/cache/` 下的"多级缓存"文件均为 0 字节占位）。

```dart
// 按需声明 provider（参考既有的 imageMemoryCacheProvider / svgCacheProvider）
final userCacheProvider = Provider<CacheManager<UserEntity>>(
  (ref) => CacheManager<UserEntity>(maxItems: 100),
);

final cache = ref.watch(userCacheProvider);
cache.setItem('user_1', userEntity);        // 同步方法，返回 void
final cached = cache.getItem('user_1');      // 未命中返回 null
```

> 注意：不存在 `userDiskCacheProvider`。

## 动态主题

色板由 `flex_color_scheme` 生成，支持 4 套配色（`AppThemeColor.blue / purple / green / red`），主题模式与配色都持久化在 SharedPreferences：

```dart
// core/providers/theme_providers.dart：themeModeProvider / themeColorProvider / appThemesProvider
final themeMode = ref.watch(themeModeProvider);
final themes = ref.watch(appThemesProvider); // = AppTheme.build(themeColorProvider 的当前值)

MaterialApp.router(
  theme: themes.light,
  darkTheme: themes.dark,
  themeMode: themeMode,
  ...
);
```

切换配色：`ref.read(themeColorProvider.notifier).set(AppThemeColor.green)`（UI 入口：`features/settings/.../theme_settings_screen.dart`）。

> 注意：`AppTheme.lightTheme` / `darkTheme` 已不存在，改用 `AppTheme.build(color)` 返回 `(light:, dark:)` 记录。

## 无障碍支持

> **注意**：`core/accessibility/` 模块当前为占位目录，待后续实现。

## 离线优先架构（部分实现）

`offlineSyncServiceProvider`、`pendingChangesProvider` 与三种冲突策略（ClientWins / ServerWins / SmartMerge）已就位，但**同步流程是模拟的**：`_processChange` 只延时后返回成功、冲突策略未接线、`pendingChangesProvider` 依赖的流是坏的 mock，也未与 WorkManager 联动。仅作设计参考。

详情请参见[离线架构指南](https://jessejii.github.io/init/offline_architecture.html)。

## 应用更新流程

`updateServiceProvider` + `UpdateChecker` 可用，**强制更新 UI 链路真实**（不可关闭的弹窗），但版本检查数据是伪造的（总是"当前版本 +1"），接入真实接口前仅供演示。

## 应用评价系统

> **未实现**：仓库中没有 `in_app_review` 依赖，也没有相关代码。
