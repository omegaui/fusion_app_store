import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:fusion_app_store/app/auth/presentation/auth_page.dart';
import 'package:fusion_app_store/app/dashboard/domain/arguments/dashboard_page_arguments.dart';
import 'package:fusion_app_store/app/dashboard/presentation/dashboard_page.dart';
import 'package:fusion_app_store/app/error/presentation/error_page.dart';
import 'package:fusion_app_store/app/home/presentation/home_page.dart';
import 'package:fusion_app_store/app/onboarding/presentation/onboarding_page.dart';
import 'package:fusion_app_store/app/search/presentation/search_page.dart';
import 'package:fusion_app_store/app/store/domain/arguments/store_page_arguments.dart';
import 'package:fusion_app_store/app/store/presentation/appview/appview_page.dart';
import 'package:fusion_app_store/app/store/presentation/store/store_page.dart';
import 'package:fusion_app_store/app/store/presentation/userview/userview_page.dart';
import 'package:fusion_app_store/core/local_storage/database.dart';
import 'package:get/get.dart';

class RouteService {
  static const homePage = "/";
  static const errorPage = "/error";
  static const authPage = "/auth";
  static const onBoardingPage = "/onboarding";
  static const storePage = "/store";
  static const appPage = "/app";
  static const userPage = "/user";
  static const searchPage = "/search";
  static const dashboardPage = "/dashboard";
  static const _databaseOverviewPage = "/database-overview";

  /// A list of [GetPage] objects representing the pages in the app.
  final List<GetPage<dynamic>> pages = [
    GetPage(
      name: homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: errorPage,
      page: () => const ErrorPage(),
    ),
    GetPage(
      name: authPage,
      page: () => const AuthPage(),
    ),
    GetPage(
      name: onBoardingPage,
      page: () => const OnBoardingPage(),
    ),
    GetPage(
      name: storePage,
      page: () => StorePage(
        arguments: Get.arguments ?? StorePageArguments(),
      ),
    ),
    GetPage(
      name: appPage,
      parameters: _parameters(['id']),
      page: () => const AppViewPage(),
    ),
    GetPage(
      name: userPage,
      parameters: _parameters(['id']),
      page: () => const UserViewPage(),
    ),
    GetPage(
      name: searchPage,
      parameters: _parameters(['query', 'platform']),
      page: () => const SearchPage(),
    ),
    GetPage(
      name: dashboardPage,
      page: () => DashboardPage(
        arguments: Get.arguments ??
            DashboardPageArguments(isOnBoarded: false, isUserLoggedIn: false),
      ),
    ),
    GetPage(
      name: _databaseOverviewPage,
      page: () => DriftDbViewer(Get.find<FusionDatabase>()),
    ),
  ];

  void navigateTo({
    required String page,
    dynamic arguments,
    dynamic parameters,
    bool shouldReplace = false,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (shouldReplace) {
        Get.offNamed(page, arguments: arguments, parameters: parameters);
        return;
      }
      Get.toNamed(page, arguments: arguments, parameters: parameters);
    });
  }

  static Map<String, String> _parameters(List<String> keys) {
    debugPrint(Get.currentRoute);
    final result = <String, String>{};
    final queryParams = {
      ...Get.parameters,
    };
    for (final key in keys) {
      queryParams.putIfAbsent(key, () => null);
    }
    for (final param in queryParams.entries) {
      result[param.key] = param.value ?? "";
    }
    return result;
  }
}
