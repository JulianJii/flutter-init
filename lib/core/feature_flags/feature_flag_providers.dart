import 'package:material_ui/material_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:init/core/analytics/analytics_providers.dart';
import 'package:init/core/feature_flags/feature_flag_service.dart';
import 'package:init/core/feature_flags/local_feature_flag_service.dart';
import 'package:init/core/feature_flags/remote_feature_flag_service.dart';

part 'feature_flag_providers.g.dart';

/// 默认功能开关的键
const Map<String, dynamic> kDefaultFeatureFlags = {
  // 功能开关
  'enable_dark_mode': true,
  'enable_push_notifications': true,
  'enable_analytics': true,
  'enable_crash_reporting': true,
  'enable_biometric_login': true,
  'use_debug_biometrics': false,
  'force_firebase_analytics': false,

  // 功能参数
  'cache_ttl_seconds': 3600,
  'api_timeout_ms': 30000,
  'max_retry_count': 3,

  // A/B 测试变体
  'home_screen_layout': 'grid', // 'grid' 或 'list'
  'onboarding_screens_count': 3,

  // 设计值
  'primary_color': '#FF2196F3',
  'corner_radius': 8.0,
};

/// 功能开关服务的 Provider
@Riverpod(keepAlive: true)
FeatureFlagService featureFlagService(Ref ref) {
  // 生产环境使用远程功能开关，调试模式使用本地功能开关
  final service =
      kDebugMode
          ? LocalFeatureFlagService() as FeatureFlagService
          : RemoteFeatureFlagService();

  // 设置默认值
  service.setDefaults(kDefaultFeatureFlags);

  // 初始化服务
  service.init();

  // 设置分析追踪
  final analytics = ref.watch(analyticsProvider);
  service.addListener(() {
    analytics.logUserAction(
      action: 'feature_flags_updated',
      category: 'config',
    );
  });

  // 当 provider 被销毁时释放服务
  ref.onDispose(() {
    // 由于我们在上方创建了它，因此可知它是 LocalFeatureFlagService
    service.dispose();
  });

  return service;
}

/// 功能开关的 provider（按 key 参数化）
@Riverpod(keepAlive: true)
bool featureFlag(Ref ref, String flagKey, {bool defaultValue = false}) {
  final service = ref.watch(featureFlagServiceProvider);
  return service.getBool(flagKey, defaultValue: defaultValue);
}

/// 字符串配置值的 provider
@Riverpod(keepAlive: true)
String stringConfig(Ref ref, String key, {required String defaultValue}) {
  final service = ref.watch(featureFlagServiceProvider);
  return service.getString(key, defaultValue: defaultValue);
}

/// 整数配置值的 provider
@Riverpod(keepAlive: true)
int intConfig(Ref ref, String key, {required int defaultValue}) {
  final service = ref.watch(featureFlagServiceProvider);
  return service.getInt(key, defaultValue: defaultValue);
}

/// 浮点配置值的 provider
@Riverpod(keepAlive: true)
double doubleConfig(Ref ref, String key, {required double defaultValue}) {
  final service = ref.watch(featureFlagServiceProvider);
  return service.getDouble(key, defaultValue: defaultValue);
}

/// 颜色配置值的 provider
@Riverpod(keepAlive: true)
Color colorConfig(Ref ref, String key, {required Color defaultValue}) {
  final service = ref.watch(featureFlagServiceProvider);
  return service.getColor(key, defaultValue: defaultValue);
}

/// 仅在功能开关启用时显示其子组件的 widget
class FeatureFlag extends ConsumerWidget {
  final String featureKey;
  final bool defaultValue;
  final Widget child;
  final Widget? fallback;

  const FeatureFlag({
    super.key,
    required this.featureKey,
    this.defaultValue = false,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(featureFlagServiceProvider);
    final enabled = service.getBool(featureKey, defaultValue: defaultValue);

    if (enabled) {
      return child;
    } else {
      return fallback ?? const SizedBox.shrink();
    }
  }
}
