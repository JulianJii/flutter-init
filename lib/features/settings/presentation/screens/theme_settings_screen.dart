import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:init/core/providers/theme_providers.dart';
import 'package:init/core/theme/app_theme.dart';
import 'package:init/gen/l10n/app_localizations.dart';

/// 主题设置页面：主题模式与配色方案，选择即时生效并持久化
class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.theme_settings)),
      body: ListView(
        children: [
          // 主题模式：浅色 / 深色 / 跟随系统
          _SectionTitle(title: l10n.theme_mode),
          ...ThemeMode.values.map(
            (ThemeMode mode) => _OptionTile(
              title: _themeModeLabel(l10n, mode),
              icon: _themeModeIcon(mode),
              selected: themeMode == mode,
              onTap: () async {
                await ref.read(themeModeProvider.notifier).set(mode);
              },
            ),
          ),

          const Divider(),

          // 配色方案
          _SectionTitle(title: l10n.theme_color),
          ...AppThemeColor.values.map(
            (AppThemeColor color) => _OptionTile(
              title: _themeColorLabel(l10n, color),
              leading: _ColorDot(color: color.seedColor),
              selected: themeColor == color,
              onTap: () async {
                await ref.read(themeColorProvider.notifier).set(color);
              },
            ),
          ),

          const Divider(),

          // 效果预览：用当前主题渲染真实控件
          _SectionTitle(title: l10n.theme_preview),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: _ThemePreview(),
          ),

          // 说明文字
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.theme_explanation,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

String _themeModeLabel(AppLocalizations l10n, ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return l10n.light_mode;
    case ThemeMode.dark:
      return l10n.dark_mode;
    case ThemeMode.system:
      return l10n.system_mode;
  }
}

IconData _themeModeIcon(ThemeMode mode) {
  switch (mode) {
    case ThemeMode.light:
      return Icons.light_mode;
    case ThemeMode.dark:
      return Icons.dark_mode;
    case ThemeMode.system:
      return Icons.brightness_auto;
  }
}

String _themeColorLabel(AppLocalizations l10n, AppThemeColor color) {
  switch (color) {
    case AppThemeColor.blue:
      return l10n.theme_color_blue;
    case AppThemeColor.purple:
      return l10n.theme_color_purple;
    case AppThemeColor.green:
      return l10n.theme_color_green;
    case AppThemeColor.red:
      return l10n.theme_color_red;
  }
}

/// 分区标题
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// 单选项：选中时显示绿勾，并用 [ListTile.selected] 高亮
class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.title,
    required this.selected,
    required this.onTap,
    this.icon,
    this.leading,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ?? (icon != null ? Icon(icon) : null),
      title: Text(title),
      selected: selected,
      trailing: AnimatedOpacity(
        opacity: selected ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: const Icon(Icons.check, color: Colors.green),
      ),
      onTap: onTap,
    );
  }
}

/// 配色预览色块
class _ColorDot extends StatelessWidget {
  const _ColorDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}

/// 用当前主题渲染的示例控件
class _ThemePreview extends StatelessWidget {
  const _ThemePreview();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  child: const Icon(Icons.palette),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Primary',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Preview',
                hintText: 'Input',
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Primary')),
                OutlinedButton(onPressed: () {}, child: const Text('Outline')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Chip(
                  avatar: Icon(
                    Icons.check,
                    color: colorScheme.onSecondaryContainer,
                  ),
                  label: const Text('Chip'),
                ),
                const SizedBox(width: 8),
                const Switch(value: true, onChanged: null),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
