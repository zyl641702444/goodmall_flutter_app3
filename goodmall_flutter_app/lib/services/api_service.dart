import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiResult {
  const ApiResult({
    required this.code,
    required this.message,
    required this.data,
    required this.raw,
  });

  final int code;
  final String message;
  final Map<String, dynamic> data;
  final String raw;

  bool get ok => code == 0;

  factory ApiResult.fromText(String text) {
    try {
      final decoded = jsonDecode(text);
      if (decoded is Map<String, dynamic>) {
        final dynamic dataValue = decoded['data'];
        return ApiResult(
          code: decoded['code'] is int
              ? decoded['code'] as int
              : int.tryParse('${decoded['code']}') ?? 998,
          message: '${decoded['message'] ?? ''}',
          data: dataValue is Map<String, dynamic>
              ? dataValue
              : <String, dynamic>{},
          raw: text,
        );
      }
    } catch (_) {}
    return ApiResult(
        code: 998, message: 'NOT_JSON', data: <String, dynamic>{}, raw: text);
  }
}

class GoodMallApiService {
  GoodMallApiService({
    this.baseUrl = 'https://api-test.khmail.cn/native-api/index.php',
    this.token = 'khmail_admin',
  });

  final String baseUrl;
  final String token;

  Future<ApiResult> get(String path,
      {Map<String, String> params = const {}}) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {
      'path': path,
      'token': token,
      ...params,
    });

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 25));
      return ApiResult.fromText(utf8.decode(response.bodyBytes));
    } catch (e) {
      return ApiResult(
          code: 999, message: 'NETWORK_ERROR: $e', data: {}, raw: '');
    }
  }

  Future<ApiResult> check() => get('v25-v39/check');

  Future<ApiResult> searchGoods(
          {String keyword = '', String pageSize = '20'}) =>
      get('v25/search-auto',
          params: {'keyword': keyword, 'pageSize': pageSize});

  Future<ApiResult> goodsDetail(String id) =>
      get('v26/goods-detail-full', params: {'id': id});

  Future<ApiResult> createOrder(
          {String goodsId = '1',
          String amount = '0',
          String userKey = 'app_user'}) =>
      get('v28/order/create',
          params: {'goods_id': goodsId, 'amount': amount, 'user_key': userKey});

  Future<ApiResult> payGoods(String orderId) =>
      get('v28/order/pay-goods', params: {'order_id': orderId});

  Future<ApiResult> createPackage(String orderId) =>
      get('v29/package/create', params: {'order_id': orderId});

  Future<ApiResult> packageDetail(String packageId) =>
      get('v29/package/detail', params: {'package_id': packageId});

  Future<ApiResult> setInternationalFee(String packageId) =>
      get('v30/shipping/set-fee', params: {
        'package_id': packageId,
        'international_fee': '4.5',
        'weight': '1',
      });

  Future<ApiResult> payInternationalFee(String packageId) =>
      get('v30/shipping/pay', params: {'package_id': packageId});

  Future<ApiResult> createPickupCode(String packageId) =>
      get('v31/pickup/create-code', params: {'package_id': packageId});

  Future<ApiResult> deliveryCreate() => get('v32/delivery/create');
  Future<ApiResult> walletLogs() => get('v33/wallet/logs');
  Future<ApiResult> creditInfo() => get('v34/credit/info');
  Future<ApiResult> merchantApply() => get('v35/merchant/apply');
  Future<ApiResult> merchantQuota() => get('v36/merchant/collect-quota');

  Future<ApiResult> affiliateClick(String goodsId) =>
      get('v37/affiliate/click', params: {'goods_id': goodsId});

  Future<ApiResult> aiChat(String prompt) =>
      get('v38/ai/chat', params: {'prompt': prompt});

  Future<ApiResult> adminSummary() => get('v39/admin/summary');
  Future<ApiResult> categories() => get('v42/categories');
  Future<ApiResult> goodsRichDetail(String goodsId) =>
      get('v43/goods-rich-detail', params: {'goods_id': goodsId});
  Future<ApiResult> cartList() => get('v44/cart/list');
  Future<ApiResult> cartAdd(String goodsId) =>
      get('v44/cart/add', params: {'goods_id': goodsId});
  Future<ApiResult> checkoutPreview() => get('v45/checkout/preview');
  Future<ApiResult> orderList() => get('v46/orders/list');
  Future<ApiResult> logisticsTimeline(String packageId) =>
      get('v47/logistics/timeline', params: {'package_id': packageId});
  Future<ApiResult> shippingPreview(String packageId) =>
      get('v48/shipping/preview', params: {'package_id': packageId});
  Future<ApiResult> pickupInfo(String packageId) =>
      get('v49/pickup/info', params: {'package_id': packageId});
  Future<ApiResult> deliveryDetail() => get('v50/delivery/detail');
  Future<ApiResult> merchantCenter() => get('v51/merchant/center');
  Future<ApiResult> merchantPaidCollect() => get('v52/merchant/paid-collect');
  Future<ApiResult> merchantGoodsList() => get('v53/merchant/goods');
  Future<ApiResult> merchantOrderList() => get('v54/merchant/orders');
  Future<ApiResult> walletFull() => get('v55/wallet/full');
  Future<ApiResult> creditFull() => get('v56/credit/full');
  Future<ApiResult> affiliateCenter() => get('v57/affiliate/center');
  Future<ApiResult> aiCustomerService() => get('v58/ai/customer-service');
  Future<ApiResult> aiMarketing(String title) =>
      get('v59/ai/marketing', params: {'title': title});
  Future<ApiResult> kgSummary() => get('v60/kg/summary');
  Future<ApiResult> adminDashboard() => get('v61/admin/dashboard');
  Future<ApiResult> adminOrders() => get('v62/admin/orders');
  Future<ApiResult> adminLogistics() => get('v63/admin/logistics');
  Future<ApiResult> checkV42V63() => get('v42-v63/check');

  Future<ApiResult> merchantAdmin() => get('v64/merchant-admin');
  Future<ApiResult> financeAdmin() => get('v65/finance-admin');
  Future<ApiResult> riskAdmin() => get('v66/risk-admin');
  Future<ApiResult> operationConfig() => get('v67/operation-config');
  Future<ApiResult> pickupVerify() => get('v68/pickup-verify');
  Future<ApiResult> customsExport() => get('v69/customs-export');
  Future<ApiResult> buildEnvCheck() => get('v70/build-env-check');
  Future<ApiResult> debugApkStatus() => get('v71/debug-apk-status');
  Future<ApiResult> deviceTestGuide() => get('v72/device-test-guide');
  Future<ApiResult> releaseSigningConfig() => get('v73/release-signing-config');
  Future<ApiResult> releaseApkStatus() => get('v74/release-apk-status');
  Future<ApiResult> aabStatus() => get('v75/aab-status');
  Future<ApiResult> brandAssets() => get('v76/brand-assets');
  Future<ApiResult> permissionsInfo() => get('v77/permissions');
  Future<ApiResult> appLogTest() => get('v78/app-log');
  Future<ApiResult> performanceCheck() => get('v79/performance-check');
  Future<ApiResult> checkV64V79() => get('v64-v79/check');

  Future<ApiResult> trustGuide() => get('v89/trust-guide');
  Future<ApiResult> platformDashboard() => get('v90/platform-dashboard');
  Future<ApiResult> usersAdmin() => get('v91/users');
  Future<ApiResult> goodsAdmin() => get('v92/goods-admin');
  Future<ApiResult> ordersAdminV93() => get('v93/orders-admin');
  Future<ApiResult> packagesAdmin() => get('v94/packages-admin');
  Future<ApiResult> warehouseAdmin() => get('v95/warehouse-admin');
  Future<ApiResult> pickupPoints() => get('v96/pickup-points');
  Future<ApiResult> merchantReview() => get('v97/merchant-review');
  Future<ApiResult> financeProfitReport() => get('v98/finance-profit-report');
  Future<ApiResult> systemConfig() => get('v99/system-config');
  Future<ApiResult> merchantProfileV100() => get('v100/merchant-profile');
  Future<ApiResult> shopDecoration() => get('v101/shop-decoration');
  Future<ApiResult> merchantGoodsManage() => get('v102/merchant-goods-manage');
  Future<ApiResult> merchantTaobaoPaidCollect() =>
      get('v103/merchant-taobao-paid-collect');
  Future<ApiResult> merchantBatchMarkup() => get('v104/merchant-batch-markup');
  Future<ApiResult> merchantOrderProcess() =>
      get('v105/merchant-order-process');
  Future<ApiResult> merchantWalletSettlement() =>
      get('v106/merchant-wallet-settlement');
  Future<ApiResult> merchantDashboardV107() => get('v107/merchant-dashboard');
  Future<ApiResult> merchantViolationReview() =>
      get('v108/merchant-violation-review');
  Future<ApiResult> merchantAdSlot() => get('v109/merchant-ad-slot');
  Future<ApiResult> payGoodsFlow() => get('v110/pay-goods-flow');
  Future<ApiResult> payInternationalShippingFlow() =>
      get('v111/pay-international-shipping-flow');
  Future<ApiResult> payLocalDeliveryFlow() =>
      get('v112/pay-local-delivery-flow');
  Future<ApiResult> walletRechargeRefundFreeze() =>
      get('v113/wallet-recharge-refund-freeze');
  Future<ApiResult> paymentReconcile() => get('v114/payment-reconcile');
  Future<ApiResult> creditLimitCalc() => get('v115/credit-limit-calc');
  Future<ApiResult> creditBills() => get('v116/credit-bills');
  Future<ApiResult> creditOverdueLimit() => get('v117/credit-overdue-limit');
  Future<ApiResult> customerProfitCalc() => get('v118/customer-profit-calc');
  Future<ApiResult> riskRuleAdmin() => get('v119/risk-rule-admin');
  Future<ApiResult> affiliateCenterV120() => get('v120/affiliate-center');
  Future<ApiResult> shareLink() => get('v121/share-link');
  Future<ApiResult> shareCode() => get('v122/share-code');
  Future<ApiResult> sharePoster() => get('v123/share-poster');
  Future<ApiResult> clickStats() => get('v124/click-stats');
  Future<ApiResult> dealStats() => get('v125/deal-stats');
  Future<ApiResult> commissionCalc() => get('v126/commission-calc');
  Future<ApiResult> commissionWithdraw() => get('v127/commission-withdraw');
  Future<ApiResult> affiliateRisk() => get('v128/affiliate-risk');
  Future<ApiResult> socialShareCard() => get('v129/social-share-card');
  Future<ApiResult> aiCustomerServiceV130() => get('v130/ai-customer-service');
  Future<ApiResult> aiRecommend() => get('v131/ai-recommend');
  Future<ApiResult> aiMarketingCopy() => get('v132/ai-marketing-copy');
  Future<ApiResult> aiPoster() => get('v133/ai-poster');
  Future<ApiResult> aiLogisticsEta() => get('v134/ai-logistics-eta');
  Future<ApiResult> aiCreditRisk() => get('v135/ai-credit-risk');
  Future<ApiResult> aiProductSelection() => get('v136/ai-product-selection');
  Future<ApiResult> aiMerchantAssistant() => get('v137/ai-merchant-assistant');
  Future<ApiResult> aiFreeShippingClassify() =>
      get('v138/ai-free-shipping-classify');
  Future<ApiResult> aiKnowledgeTrain() => get('v139/ai-knowledge-train');
  Future<ApiResult> kgProducts() => get('v140/kg-products');
  Future<ApiResult> kgCategoriesV141() => get('v141/kg-categories');
  Future<ApiResult> kgSearch() => get('v142/kg-search');
  Future<ApiResult> kgUserBehavior() => get('v143/kg-user-behavior');
  Future<ApiResult> kgLogistics() => get('v144/kg-logistics');
  Future<ApiResult> kgCredit() => get('v145/kg-credit');
  Future<ApiResult> kgMerchant() => get('v146/kg-merchant');
  Future<ApiResult> kgAffiliate() => get('v147/kg-affiliate');
  Future<ApiResult> kgAiService() => get('v148/kg-ai-service');
  Future<ApiResult> kgRecommend() => get('v149/kg-recommend');
  Future<ApiResult> rateLimit() => get('v150/rate-limit');
  Future<ApiResult> antiAbuse() => get('v151/anti-abuse');
  Future<ApiResult> cacheOptimize() => get('v152/cache-optimize');
  Future<ApiResult> searchPerformance() => get('v153/search-performance');
  Future<ApiResult> imagePerformance() => get('v154/image-performance');
  Future<ApiResult> logSystem() => get('v155/log-system');
  Future<ApiResult> alertSystem() => get('v156/alert-system');
  Future<ApiResult> dbIndexes() => get('v157/db-indexes');
  Future<ApiResult> backupRestore() => get('v158/backup-restore');
  Future<ApiResult> permissionSecurity() => get('v159/permission-security');
  Future<ApiResult> privacyPolicyV160() => get('v160/privacy-policy');
  Future<ApiResult> checkV89V160() => get('v89-v160/check');

  Future<ApiResult> payChannelListV180() => get('v180/pay-channel-list');
  Future<ApiResult> payCreateV181() => get('v181/pay-create');
  Future<ApiResult> payCallbackV182() => get('v182/pay-callback');
  Future<ApiResult> payQueryV183() => get('v183/pay-query');
  Future<ApiResult> refundCreateV184() => get('v184/refund-create');
  Future<ApiResult> walletRechargeRealV185() =>
      get('v185/wallet-recharge-real');
  Future<ApiResult> paymentReconcileRealV186() =>
      get('v186/payment-reconcile-real');
  Future<ApiResult> khqrConfigV187() => get('v187/khqr-config');
  Future<ApiResult> cryptoUsdtConfigV188() => get('v188/crypto-usdt-config');
  Future<ApiResult> paymentSecurityV189() => get('v189/payment-security');
  Future<ApiResult> merchantLoginV190() => get('v190/merchant-login');
  Future<ApiResult> merchantPermissionsV191() =>
      get('v191/merchant-permissions');
  Future<ApiResult> storeProfileSaveV192() => get('v192/store-profile-save');
  Future<ApiResult> merchantProductPublishV193() =>
      get('v193/merchant-product-publish');
  Future<ApiResult> merchantProductAuditV194() =>
      get('v194/merchant-product-audit');
  Future<ApiResult> merchantCollectPlanBuyV195() =>
      get('v195/merchant-collect-plan-buy');
  Future<ApiResult> merchantOrderWorkbenchV196() =>
      get('v196/merchant-order-workbench');
  Future<ApiResult> merchantSettlementRealV197() =>
      get('v197/merchant-settlement-real');
  Future<ApiResult> merchantServiceCenterV198() =>
      get('v198/merchant-service-center');
  Future<ApiResult> merchantDataDashboardV199() =>
      get('v199/merchant-data-dashboard');
  Future<ApiResult> checkV180V199() => get('v180-v199/check');

  Future<ApiResult> checkV200V998() => get('v200-v998/check');
  Future<ApiResult> dashboardV200V998() => get('v200-v998/dashboard');
  Future<ApiResult> exportRoadmapV200V998() => get('v200-v998/export-roadmap');
  Future<ApiResult> groupV200V229() => get('v200-v229/group');
  Future<ApiResult> groupV230V249() => get('v230-v249/group');
  Future<ApiResult> groupV250V259() => get('v250-v259/group');
  Future<ApiResult> groupV260V289() => get('v260-v289/group');
  Future<ApiResult> groupV290V319() => get('v290-v319/group');
  Future<ApiResult> groupV320V359() => get('v320-v359/group');
  Future<ApiResult> groupV360V399() => get('v360-v399/group');
  Future<ApiResult> groupV400V599() => get('v400-v599/group');
  Future<ApiResult> groupV600V799() => get('v600-v799/group');
  Future<ApiResult> groupV800V998() => get('v800-v998/group');
  Future<ApiResult> versionStatusV200V998(String version) =>
      get('v$version/status');

  Future<ApiResult> fullCheck() => get('full/check');
  Future<ApiResult> fullDashboard() => get('full/dashboard');
  Future<ApiResult> fullGoodsSearch({String keyword = ''}) =>
      get('full/goods/search', params: {'keyword': keyword});
  Future<ApiResult> fullGoodsDetail(String goodsId) =>
      get('full/goods/detail', params: {'goods_id': goodsId});
  Future<ApiResult> fullOrderCreate(
          {String amount = '9.9', String goodsId = '1'}) =>
      get('full/order/create', params: {'amount': amount, 'goods_id': goodsId});
  Future<ApiResult> fullPaymentProof(String orderNo, String amount) =>
      get('full/payment/proof',
          params: {'order_no': orderNo, 'amount': amount});
  Future<ApiResult> fullOrders() => get('full/orders');
  Future<ApiResult> fullPackages() => get('full/packages');
  Future<ApiResult> fullWarehouseInbound(String packageId) =>
      get('full/warehouse/inbound', params: {'package_id': packageId});
  Future<ApiResult> fullShippingPay(String packageId) =>
      get('full/shipping/pay', params: {'package_id': packageId});
  Future<ApiResult> fullWalletLogs() => get('full/wallet/logs');
  Future<ApiResult> fullCreditInfo() => get('full/credit/info');
  Future<ApiResult> fullFinanceReport() => get('full/finance/report');
  Future<ApiResult> fullMerchantApply() => get('full/merchant/apply');
  Future<ApiResult> fullAiChat(String question) =>
      get('full/ai/chat', params: {'question': question});
}
