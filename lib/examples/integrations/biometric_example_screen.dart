import 'package:flutter/material.dart';

import '../biometrics_demo.dart';

/// [BiometricsDemo] 的一个轻量级包装器——为已完整实现的生物识别认证演示补上 Scaffold。
///
/// 注意：本页只提供页面外壳，并未注册路由（AppRoutes.biometricDemo 未在 app_router.dart 中注册），
/// 因此从运行的应用里仍无法访问，需先补注册路由或直接构造该 widget。
class BiometricExampleScreen extends StatelessWidget {
  const BiometricExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric authentication')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: BiometricsDemo(),
      ),
    );
  }
}
