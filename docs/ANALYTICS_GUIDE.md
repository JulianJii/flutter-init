# 分析系统指南

本指南介绍如何使用 Flutter Riverpod Clean Architecture 模板中的分析系统。

## 概述

分析系统提供以下功能：

- 应用程序范围内的标准化事件跟踪
- 支持多种分析提供商（Firebase Analytics 等）
- 隐私控制，支持便捷的启用/禁用选项
- 页面浏览、用户操作、错误和性能跟踪
- 用户属性管理
- 开发调试工具

## 目录结构

```dart
lib/core/analytics/
├── analytics_event.dart      # Event models and definitions
├── analytics_providers.dart  # Riverpod providers
├── analytics_service.dart    # Service interfaces
└── firebase_analytics_service.dart  # Firebase implementation
```

## 使用方法

### 跟踪页面浏览

```dart
final analytics = ref.watch(analyticsProvider);

// Simple screen view
analytics.logScreenView('HomeScreen');

// With additional parameters
analytics.logScreenView('ProductScreen', parameters: {
  'product_id': '123',
  'category': 'electronics',
});
```

### 跟踪用户操作

```dart
analytics.logUserAction(
  action: 'button_click',
  category: 'navigation',
  label: 'settings_button',
);

// With additional parameters
analytics.logUserAction(
  action: 'item_added_to_cart',
  category: 'ecommerce',
  parameters: {
    'product_id': '123',
    'price': 49.99,
    'currency': 'USD',
  },
);
```

### 跟踪错误

```dart
try {
  // Some operation
} catch (e, stackTrace) {
  analytics.logError(
    errorType: 'api_error',
    message: e.toString(),
    stackTrace: stackTrace.toString(),
  );
}
```

### 跟踪性能

```dart
final startTime = DateTime.now();
// Perform some operation
final duration = DateTime.now().difference(startTime);

analytics.logPerformance(
  name: 'api_request_time', // 参数名是 name（不是 metricName）
  value: duration.inMilliseconds,
  unit: 'ms',
);
```

### 管理用户属性

```dart
// Set user ID and properties
analytics.setUser(
  userId: 'user-123',
  properties: {
    'subscription_level': 'premium',
  },
);

// Clear user data (e.g., on logout)
analytics.resetUser();
```

### 隐私控制

```dart
final analytics = ref.watch(analyticsProvider);

// Check if analytics is enabled
final isEnabled = analytics.isEnabled;

// Enable analytics
analytics.enable();

// Disable analytics
analytics.disable();
```

## 与 Feature Flags 集成

数据收集可通过 Feature Flags 进行控制：

```dart
final analyticsEnabled = ref.watch(
  featureFlagProvider('enable_analytics', defaultValue: true),
);

if (analyticsEnabled) {
  analytics.enable();
} else {
  analytics.disable();
}
```

## 事件类型

系统支持以下标准事件类型：

1. **ScreenViewEvent** - 页面浏览和屏幕导航
2. **UserActionEvent** - 用户交互和参与
3. **ErrorEvent** - 错误跟踪和崩溃报告
4. **PerformanceEvent** - 性能指标和计时

可以通过继承 `AnalyticsEvent` 基类创建自定义事件类型。

## 实现细节

### CompositeAnalyticsService

系统使用组合模式同时启用多个分析提供商：

```dart
final service = CompositeAnalyticsService([
  FirebaseAnalyticsService(),
  DebugAnalyticsService(),
  // Add other providers as needed
]);
```

### 开发环境与生产环境

- Debug 构建包含 `DebugAnalyticsService`，用于开发时的可见性。
- Release 构建会拼上 `FirebaseAnalyticsService`，但它同样是 stub（见下节），接好 Firebase 前不要指望线上有数据。
- 两种实现共享同一个 `AnalyticsService` 接口。

## Firebase 集成

> **注意**：当前 `FirebaseAnalyticsService` 为 stub 实现（使用 `debugPrint`）。要启用真实的 Firebase Analytics：

1. 在 `pubspec.yaml` 中添加 `firebase_analytics` 依赖
2. 在您的应用中配置 Firebase
3. 更新 `FirebaseAnalyticsService` 实现以使用真实的 Firebase SDK

## 调试与隐私

在开发环境中所有事件都走 `DebugAnalyticsService`（打印到日志），这是当前唯一的可见手段。
开关用 `analytics.enable()` / `disable()`，也可用 `featureFlagProvider('enable_analytics', ...)`
统一控制；上线前在隐私政策里写明收集范围，且不要把 PII 放进 `parameters`。
