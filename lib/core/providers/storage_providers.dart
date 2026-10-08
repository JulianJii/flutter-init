// 存储相关 Provider
// 用于存储相关服务的 Riverpod Provider

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/local_storage_service.dart';

part 'storage_providers.g.dart';

/// SharedPreferences 实例的 Provider（main.dart 用真实实例覆盖）
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

/// LocalStorageService 实例的 Provider
@Riverpod(keepAlive: true)
LocalStorageService localStorageService(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocalStorageService(prefs);
}
