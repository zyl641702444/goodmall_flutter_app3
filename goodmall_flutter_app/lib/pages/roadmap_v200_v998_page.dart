import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_blocks.dart';

class RoadmapV200V998Page extends StatefulWidget {
  const RoadmapV200V998Page({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  State<RoadmapV200V998Page> createState() => _RoadmapV200V998PageState();
}

class _RoadmapV200V998PageState extends State<RoadmapV200V998Page> {
  final api = GoodMallApiService();
  String output = 'V200-V998 路线总控中心';

  Future<void> call(String title, Future<ApiResult> future) async {
    setState(() => output = 'loading $title...');
    final r = await future;
    setState(() => output = r.raw);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.themeController.current;
    final buttons = <MapEntry<String, Future<ApiResult> Function()>>[
      MapEntry('全量检查', () => api.checkV200V998()),
      MapEntry('总控台', () => api.dashboardV200V998()),
      MapEntry('导出路线', () => api.exportRoadmapV200V998()),
      MapEntry('V200-V229', () => api.groupV200V229()),
      MapEntry('V230-V249', () => api.groupV230V249()),
      MapEntry('V250-V259', () => api.groupV250V259()),
      MapEntry('V260-V289', () => api.groupV260V289()),
      MapEntry('V290-V319', () => api.groupV290V319()),
      MapEntry('V320-V359', () => api.groupV320V359()),
      MapEntry('V360-V399', () => api.groupV360V399()),
      MapEntry('V400-V599', () => api.groupV400V599()),
      MapEntry('V600-V799', () => api.groupV600V799()),
      MapEntry('V800-V998', () => api.groupV800V998()),
      MapEntry('V230 状态', () => api.versionStatusV200V998('230')),
      MapEntry('V399 状态', () => api.versionStatusV200V998('399')),
      MapEntry('V599 状态', () => api.versionStatusV200V998('599')),
      MapEntry('V998 状态', () => api.versionStatusV200V998('998')),
    ];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(title: const Text('V200-V998 总路线')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(
            theme: theme,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('GoodMall Scale Roadmap',
                  style: TextStyle(
                      color: theme.text,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('从平台后台、真实支付、仓库、商家、推广、AI、知识图谱，到集团管理、供应链、多端、开放平台和生态级平台。',
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
