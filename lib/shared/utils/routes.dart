import 'package:anglara_tech_task/features/presentations/category_product_list_page/category_prodyct_list_page.dart';
import 'package:anglara_tech_task/features/presentations/home_page/home_page.dart';
import 'package:anglara_tech_task/features/presentations/login_page/login_page.dart';
import 'package:anglara_tech_task/features/presentations/product_detail_page.dart/product_detail_page.dart';
import 'package:anglara_tech_task/features/presentations/registration_page/registration_page.dart';
import 'package:anglara_tech_task/features/presentations/search_products/search_product_page.dart';
import 'package:flutter/material.dart';

import '../constants/route_constants.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() => {
        RouteList.initial: (context) => const LoginPage(),
        RouteList.registerUser: (context) => const RegisterUser(),
        RouteList.homeScreen: (context) => const HomePage(),
        RouteList.categoryProductsList: (context) =>
            const CategoryProductsListPage(),
        RouteList.productDetail: (context) => const ProductDetailPage(),
        RouteList.searchProduct: (context) => const SearchProductPage()
      };
}
