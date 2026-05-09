import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_blocks.dart';

class AdminOpsPage extends StatefulWidget {
  const AdminOpsPage({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  State<AdminOpsPage> createState() => _AdminOpsPageState();
}

class _AdminOpsPageState extends State<AdminOpsPage> {
  final api = GoodMallApiService();
  String output = 'V64-V79 后台/打包/运营检测中心';

  Future<void> call(String title, Future<ApiResult> future) async {
    setState(() => output = 'loading $title...');
    final r = await future;
    setState(() => output = r.raw);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.themeController.current;
    final buttons = <MapEntry<String, Future<ApiResult> Function()>>[
      MapEntry('V64 商家后台', () => api.merchantAdmin()),
      MapEntry('V65 财务后台', () => api.financeAdmin()),
      MapEntry('V66 风控后台', () => api.riskAdmin()),
      MapEntry('V67 运营配置', () => api.operationConfig()),
      MapEntry('V68 扫码核销', () => api.pickupVerify()),
      MapEntry('V69 清关导出', () => api.customsExport()),
      MapEntry('V70 环境检测', () => api.buildEnvCheck()),
      MapEntry('V71 Debug APK', () => api.debugApkStatus()),
      MapEntry('V72 真机测试', () => api.deviceTestGuide()),
      MapEntry('V73 签名配置', () => api.releaseSigningConfig()),
      MapEntry('V74 Release APK', () => api.releaseApkStatus()),
      MapEntry('V75 AAB', () => api.aabStatus()),
      MapEntry('V76 品牌素材', () => api.brandAssets()),
      MapEntry('V77 权限整理', () => api.permissionsInfo()),
      MapEntry('V78 日志测试', () => api.appLogTest()),
      MapEntry('V79 性能检测', () => api.performanceCheck()),
    ];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(title: const Text('后台/发布中心')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(
            theme: theme,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('GoodMall Ops Center',
                  style: TextStyle(
                      color: theme.text,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('商家后台 / 财务 / 风控 / 运营配置 / 仓库核销 / 清关导出 / 打包环境检测',
                  style: TextStyle(color: theme.muted, height: 1.45)),
            ]),
          ),
          const SizedBox(height: 14),
          GlassCard(
            theme: theme,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final b in buttons)
                  FilledButton(
                    style:
                        FilledButton.styleFrom(backgroundColor: theme.primary),
                    onPressed: () => call(b.key, b.value()),
                    child: Text(b.key),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ApiOutputCard(theme: theme, output: output),
        ],
      ),
    );
  }
}
