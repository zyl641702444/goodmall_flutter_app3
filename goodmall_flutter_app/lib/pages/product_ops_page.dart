import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_blocks.dart';

class ProductOpsPage extends StatefulWidget {
  const ProductOpsPage({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  State<ProductOpsPage> createState() => _ProductOpsPageState();
}

class _ProductOpsPageState extends State<ProductOpsPage> {
  final api = GoodMallApiService();
  String output = 'V89-V160 产品运营中心';

  Future<void> call(String title, Future<ApiResult> future) async {
    setState(() => output = 'loading $title...');
    final r = await future;
    setState(() => output = r.raw);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.themeController.current;
    final buttons = <MapEntry<String, Future<ApiResult> Function()>>[
      MapEntry('V89 信任说明', () => api.trustGuide()),
      MapEntry('V90 平台后台', () => api.platformDashboard()),
      MapEntry('V91 用户管理', () => api.usersAdmin()),
      MapEntry('V92 商品管理', () => api.goodsAdmin()),
      MapEntry('V93 订单管理', () => api.ordersAdminV93()),
      MapEntry('V94 包裹管理', () => api.packagesAdmin()),
      MapEntry('V95 仓库管理', () => api.warehouseAdmin()),
      MapEntry('V96 自提点', () => api.pickupPoints()),
      MapEntry('V97 商家审核', () => api.merchantReview()),
      MapEntry('V98 财务利润', () => api.financeProfitReport()),
      MapEntry('V99 系统配置', () => api.systemConfig()),
      MapEntry('V103 商家采集', () => api.merchantTaobaoPaidCollect()),
      MapEntry('V110 商品款支付', () => api.payGoodsFlow()),
      MapEntry('V111 国际运费', () => api.payInternationalShippingFlow()),
      MapEntry('V115 信用额度', () => api.creditLimitCalc()),
      MapEntry('V120 推广中心', () => api.affiliateCenterV120()),
      MapEntry('V130 AI客服', () => api.aiCustomerServiceV130()),
      MapEntry('V140 商品图谱', () => api.kgProducts()),
      MapEntry('V150 限流', () => api.rateLimit()),
      MapEntry('V160 隐私政策', () => api.privacyPolicyV160()),
      MapEntry('全量检查', () => api.checkV89V160()),
    ];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(title: const Text('产品运营中心')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(
            theme: theme,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('GoodMall Product Center',
                  style: TextStyle(
                      color: theme.text,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('平台后台 / 商家端 / 钱包信用 / 推广 / AI / 知识图谱 / 稳定安全 / 上线材料',
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
