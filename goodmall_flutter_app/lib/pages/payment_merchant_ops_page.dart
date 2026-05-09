import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';
import '../widgets/ui_blocks.dart';

class PaymentMerchantOpsPage extends StatefulWidget {
  const PaymentMerchantOpsPage({super.key, required this.themeController});
  final ThemeController themeController;

  @override
  State<PaymentMerchantOpsPage> createState() => _PaymentMerchantOpsPageState();
}

class _PaymentMerchantOpsPageState extends State<PaymentMerchantOpsPage> {
  final api = GoodMallApiService();
  String output = 'V180-V199 支付系统 + 商家端运营中心';

  Future<void> call(String title, Future<ApiResult> future) async {
    setState(() => output = 'loading $title...');
    final r = await future;
    setState(() => output = r.raw);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.themeController.current;
    final buttons = <MapEntry<String, Future<ApiResult> Function()>>[
      MapEntry('V180 支付渠道', () => api.payChannelListV180()),
      MapEntry('V181 创建支付单', () => api.payCreateV181()),
      MapEntry('V183 支付查询', () => api.payQueryV183()),
      MapEntry('V184 退款创建', () => api.refundCreateV184()),
      MapEntry('V185 钱包充值', () => api.walletRechargeRealV185()),
      MapEntry('V186 支付对账', () => api.paymentReconcileRealV186()),
      MapEntry('V187 KHQR配置', () => api.khqrConfigV187()),
      MapEntry('V188 USDT配置', () => api.cryptoUsdtConfigV188()),
      MapEntry('V189 支付安全', () => api.paymentSecurityV189()),
      MapEntry('V190 商家登录', () => api.merchantLoginV190()),
      MapEntry('V191 商家权限', () => api.merchantPermissionsV191()),
      MapEntry('V192 店铺资料', () => api.storeProfileSaveV192()),
      MapEntry('V193 发布商品', () => api.merchantProductPublishV193()),
      MapEntry('V194 商品审核', () => api.merchantProductAuditV194()),
      MapEntry('V195 采集套餐', () => api.merchantCollectPlanBuyV195()),
      MapEntry('V196 订单工作台', () => api.merchantOrderWorkbenchV196()),
      MapEntry('V197 商家结算', () => api.merchantSettlementRealV197()),
      MapEntry('V198 商家客服', () => api.merchantServiceCenterV198()),
      MapEntry('V199 数据看板', () => api.merchantDataDashboardV199()),
      MapEntry('全量检查', () => api.checkV180V199()),
    ];

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(title: const Text('支付/商家运营')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GlassCard(
            theme: theme,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Payment & Merchant Center',
                  style: TextStyle(
                      color: theme.text,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text(
                  '真实支付渠道骨架、回调、退款、对账、钱包充值、KHQR/USDT 配置、商家登录、权限、商品、订单、结算、客服、数据看板。',
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
