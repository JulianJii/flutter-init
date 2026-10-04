import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/core/router/app_routes.dart';
import 'package:init/gen/l10n/app_localizations.dart';

/// 包含各种应用配置选项的设置页面
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        children: [
          // 语言设置
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(l10n.change_language),
            onTap: () => context.go(AppRoutes.languageSettings),
          ),

          const Divider(),

          // 主题设置
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(l10n.theme),
            subtitle: Text(l10n.change_theme),
            onTap: () {
              // 主题设置（待实现）
            },
          ),

          const Divider(),

          // 其他设置...
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(l10n.notifications),
            subtitle: Text(l10n.notification_settings),
            onTap: () {
              // 通知设置（待实现）
            },
          ),

          const Divider(),

          // 本地化示例
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.localization_demo),
            subtitle: Text(l10n.localization_demo_description),
            onTap: () => context.go(AppRoutes.localizationAssetsDemo),
          ),
        ],
      ),
    );
  }
}
