import 'package:flutter/material.dart';
import 'pages/admin_ops_page.dart';
import 'pages/affiliate_center_page.dart';
import 'pages/ai_customer_service_page.dart';
import 'pages/cart_page.dart';
import 'pages/category_page.dart';
import 'pages/credit_page.dart';
import 'pages/customs_export_page.dart';
import 'pages/delivery_page.dart';
import 'pages/detail_page.dart';
import 'pages/feature_center_page.dart';
import 'pages/finance_page.dart';
import 'pages/goods_detail_page.dart';
import 'pages/goods_list_page.dart';
import 'pages/home_page.dart';
import 'pages/image_search_page.dart';
import 'pages/knowledge_graph_page.dart';
import 'pages/logistics_page.dart';
import 'pages/merchant_center_page.dart';
import 'pages/merchant_collect_page.dart';
import 'pages/notification_page.dart';
import 'pages/order_page.dart';
import 'pages/order_result_page.dart';
import 'pages/package_page.dart';
import 'pages/payment_merchant_ops_page.dart';
import 'pages/payment_page.dart';
import 'pages/pickup_code_page.dart';
import 'pages/product_ops_page.dart';
import 'pages/profile_page.dart';
import 'pages/roadmap_v200_v998_page.dart';
import 'pages/settings_page.dart';
import 'pages/theme_page.dart';
import 'pages/ui_route_test_page.dart';
import 'pages/wallet_page.dart';
import 'pages/warehouse_center_page.dart';
import 'theme/app_theme.dart';

final ThemeController _goodMallThemeController = ThemeController();

class GoodMallRoutes {
  static const String adminOps = '/admin-ops';
  static const String affiliateCenter = '/affiliate-center';
  static const String aiCustomerService = '/ai-customer-service';
  static const String cart = '/cart';
  static const String category = '/category';
  static const String credit = '/credit';
  static const String customsExport = '/customs-export';
  static const String delivery = '/delivery';
  static const String detail = '/detail';
  static const String featureCenter = '/feature-center';
  static const String finance = '/finance';
  static const String goodsDetail = '/goods-detail';
  static const String goodsList = '/goods-list';
  static const String home = '/';
  static const String imageSearch = '/image-search';
  static const String knowledgeGraph = '/knowledge-graph';
  static const String logistics = '/logistics';
  static const String merchantCenter = '/merchant-center';
  static const String merchantCollect = '/merchant-collect';
  static const String notification = '/notification';
  static const String order = '/order';
  static const String orderResult = '/order-result';
  static const String package = '/package';
  static const String paymentMerchantOps = '/payment-merchant-ops';
  static const String payment = '/payment';
  static const String pickupCode = '/pickup-code';
  static const String productOps = '/product-ops';
  static const String profile = '/profile';
  static const String roadmapV200V998 = '/roadmap-v200-v998';
  static const String settings = '/settings';
  static const String theme = '/theme';
  static const String uiRouteTest = '/ui-route-test';
  static const String wallet = '/wallet';
  static const String warehouseCenter = '/warehouse-center';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final Object? routeArgs = routeSettings.arguments;

    final Map<String, dynamic> routeMap = routeArgs is Map
        ? Map<String, dynamic>.from(routeArgs)
        : <String, dynamic>{};

    switch (routeSettings.name) {
      case adminOps:
        return _page(AdminOpsPage(themeController: _goodMallThemeController));

      case affiliateCenter:
        return _page(AffiliateCenterPage());

      case aiCustomerService:
        return _page(AiCustomerServicePage());

      case cart:
        return _page(CartPage());

      case category:
        return _page(CategoryPage(themeController: _goodMallThemeController));

      case credit:
        return _page(CreditPage());

      case customsExport:
        return _page(CustomsExportPage());

      case delivery:
        return _page(DeliveryPage());

      case detail:
        return _page(DetailPage(
            goods: routeMap['goods'] ??
                routeMap['goods'] ??
                routeMap['item'] ??
                routeMap,
            themeController: _goodMallThemeController));

      case featureCenter:
        return _page(
            FeatureCenterPage(themeController: _goodMallThemeController));

      case finance:
        return _page(FinancePage());

      case goodsDetail:
        return _page(GoodsDetailPage());

      case goodsList:
        return _page(GoodsListPage());

      case home:
        return _page(HomePage(themeController: _goodMallThemeController));

      case imageSearch:
        return _page(
            ImageSearchPage(themeController: _goodMallThemeController));

      case knowledgeGraph:
        return _page(KnowledgeGraphPage());

      case logistics:
        return _page(LogisticsPage(themeController: _goodMallThemeController));

      case merchantCenter:
        return _page(MerchantCenterPage());

      case merchantCollect:
        return _page(MerchantCollectPage());

      case notification:
        return _page(NotificationPage());

      case order:
        return _page(OrderPage());

      case orderResult:
        return _page(OrderResultPage(
            orderRaw: routeMap['orderRaw'] ??
                routeMap['orderRaw'] ??
                routeMap['order'] ??
                routeMap,
            packageRaw: routeMap['packageRaw'] ??
                routeMap['packageRaw'] ??
                routeMap['package'] ??
                routeMap,
            packageId:
                (routeMap['packageId'] ?? routeMap['id'] ?? '').toString(),
            themeController: _goodMallThemeController));

      case package:
        return _page(PackagePage());

      case paymentMerchantOps:
        return _page(
            PaymentMerchantOpsPage(themeController: _goodMallThemeController));

      case payment:
        return _page(PaymentPage());

      case pickupCode:
        return _page(PickupCodePage());

      case productOps:
        return _page(ProductOpsPage(themeController: _goodMallThemeController));

      case profile:
        return _page(ProfilePage(themeController: _goodMallThemeController));

      case roadmapV200V998:
        return _page(
            RoadmapV200V998Page(themeController: _goodMallThemeController));

      case settings:
        return _page(SettingsPage());

      case theme:
        return _page(ThemePage());

      case uiRouteTest:
        return _page(UiRouteTestPage());

      case wallet:
        return _page(WalletPage(themeController: _goodMallThemeController));

      case warehouseCenter:
        return _page(WarehouseCenterPage());

      default:
        return _page(HomePage(themeController: _goodMallThemeController));
    }
  }

  static MaterialPageRoute<dynamic> _page(Widget page) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
    );
  }
}
