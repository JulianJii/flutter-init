---
title: 生物识别认证指南
description: Flutter 应用中生物识别认证的实现指南
---

# 生物识别认证指南

基于 `local_auth` 的指纹 / 人脸识别认证，用于保护敏感操作。

> **现状（先读）**：`LocalBiometricService` 是**真实实现**（`local_auth` 3.x，直连系统弹窗）；debug 构建下把 feature flag `use_debug_biometrics` 打开会切到 `DebugBiometricService`（无弹窗，延时后返回成功）。
> 接口只有三件事：**检测可用性、列出可用类型、发起认证**。**没有**凭证读写 API（凭据请用 `secureStorageServiceProvider`），也**没有**证书固定 / 防篡改校验 / "认证后自动解密"这类能力——本文只描述仓库里真实存在的部分。
>
> 完整可运行样例见 `lib/examples/biometrics_demo.dart`。

## 目录结构

```
lib/core/auth/
├── biometric_service.dart        # 接口 + BiometricResult / BiometricType / AuthReason 枚举
├── biometric_providers.dart      # Riverpod providers + BiometricAuthController
├── biometric_providers.g.dart    # 生成物，勿手改
├── debug_biometric_service.dart  # Debug 实现（延时 + 固定返回 success）
└── local_biometric_service.dart  # 真实实现（local_auth）
```

## 服务接口

`BiometricService`（`biometric_service.dart`）的真实签名：

```dart
abstract class BiometricService {
  Future<bool> isAvailable();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<BiometricResult> authenticate({
    required String localizedReason,
    AuthReason reason = AuthReason.appAccess,
    bool sensitiveTransaction = false,
    String? dialogTitle,
    String? cancelButtonText,
  });
}
```

- `BiometricResult`：`success / failed / cancelled / notEnrolled / notAvailable / lockedOut / error`
  （注意 `LocalBiometricService` 目前只会返回 `success / failed / notAvailable / notEnrolled / error`，`cancelled`、`lockedOut` 依赖 `local_auth` 抛出异常才会命中，实际很少出现）。
- `BiometricType`：`fingerprint / face / iris / multiple`。
- `AuthReason`：`appAccess / transaction / sensitiveData`。

## Providers

`biometric_providers.dart` 里的是 **`@riverpod` 代码生成**的 provider（不是手写 `Provider(...)`）：

```dart
// 服务本身：debug + use_debug_biometrics 时才用 DebugBiometricService，
// 否则 LocalBiometricService；返回值外层包了 _AnalyticsBiometricServiceProxy（自动埋点）
final service = ref.watch(biometricServiceProvider);

// 可用性 / 可用类型（异步，无数据时是 loading）
final available = ref.watch(biometricsAvailableProvider);   // 注意名字是复数 Available
final types = ref.watch(availableBiometricsProvider);       // List<BiometricType>
```

## 认证状态与控制器

`BiometricAuthController`（`@Riverpod(keepAlive: true)`，生成 `biometricAuthControllerProvider`）负责状态与埋点：

```dart
final state = ref.watch(biometricAuthControllerProvider);
final controller = ref.read(biometricAuthControllerProvider.notifier);

// 注意参数名：reason 是提示文案，authReason 才是 AuthReason 枚举
final result = await controller.authenticate(
  reason: 'Authenticate to access your account',
  authReason: AuthReason.appAccess,
);

// 会话超时：到期会把 isAuthenticated 置回 false 并返回 true
if (controller.isAuthenticationNeeded(timeout: const Duration(minutes: 5))) {
  // 需要重新认证
}

controller.logout(); // 清空状态（并记录一次分析事件）
```

## 使用方法

### 检查可用性后决定要不要显示入口

```dart
class BiometricLoginButton extends ConsumerWidget {
  const BiometricLoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final available = ref.watch(biometricsAvailableProvider);

    return available.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (isAvailable) => isAvailable
          ? ElevatedButton(
              onPressed: () => ref
                  .read(biometricAuthControllerProvider.notifier)
                  .authenticate(reason: 'Authenticate to sign in'),
              child: const Icon(Icons.fingerprint),
            )
          : const SizedBox.shrink(), // 不支持生物识别时走普通登录
    );
  }
}
```

### 敏感操作

```dart
final result = await ref
    .read(biometricAuthControllerProvider.notifier)
    .authenticate(
      reason: 'Authenticate to confirm payment',
      authReason: AuthReason.transaction,
      sensitiveTransaction: true, // 传给 local_auth
      dialogTitle: '身份验证',
      cancelButtonText: '取消',
    );

switch (result) {
  case BiometricResult.success:
    break;
  case BiometricResult.notAvailable:
  case BiometricResult.notEnrolled:
    // 设备不支持 / 用户未录入
    break;
  case BiometricResult.lockedOut:
    // 失败次数过多
    break;
  default:
    break;
}
```

### 认证之后再动敏感数据：用安全存储，不用生物识别服务

```dart
// secureStorageServiceProvider 定义在 features/auth/data/repositories/auth_repository_impl.dart 底部
final storage = ref.read(secureStorageServiceProvider);
await storage.write(key: 'auth_token', value: response.token);
final token = await storage.read(key: 'auth_token');
```

## 平台配置

Android（`android/app/src/main/AndroidManifest.xml`）：

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
```

iOS（`ios/Runner/Info.plist`，Face ID 必需，缺失会导致弹窗不显示）：

```xml
<key>NSFaceIDUsageDescription</key>
<string>Why you are using Face ID</string>
```

## 调试与测试

- 模拟器/桌面端没有生物识别硬件，调 `isAvailable()` 会得到 `false`；要看完整 UI 就把 feature flag `use_debug_biometrics` 设为 `true`（仅在 `kDebugMode` 下生效），此时 `DebugBiometricService` 会延时 1 秒后固定返回 `success`。
- 单测里用 `mocktail` mock 服务，并 override provider：

```dart
final mockService = MockBiometricService();
when(() => mockService.isAvailable()).thenAnswer((_) async => true);
when(() => mockService.authenticate(
  localizedReason: any(named: 'localizedReason'),
  reason: any(named: 'reason'),
  sensitiveTransaction: any(named: 'sensitiveTransaction'),
  dialogTitle: any(named: 'dialogTitle'),
  cancelButtonText: any(named: 'cancelButtonText'),
)).thenAnswer((_) async => BiometricResult.success);

final container = ProviderContainer(
  overrides: [biometricServiceProvider.overrideWithValue(mockService)],
);
```

## 问题排查

| 现象 | 原因 / 处理 |
|---|---|
| 认证恒为 `notAvailable` | 设备无硬件、功能被系统关闭、模拟器；或 `isDeviceSupported()` 为 false |
| 恒为 `notEnrolled` | 用户未录入指纹/人脸 |
| `lockedOut` | 失败次数过多，通常 30 秒后自动解锁；被永久锁定时需先输 PIN/密码 |
| iOS 不弹窗 | `Info.plist` 缺 `NSFaceIDUsageDescription` |
| Android 弹窗不出现 | 缺 `USE_BIOMETRIC` 权限，或应用不在前台 |
| 认证成功但拿不到数据 | 该接口不提供凭证存取，请检查 `secureStorageServiceProvider` 的读写 |
