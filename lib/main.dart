import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fusion_app_store/config/app_theme.dart';
import 'package:fusion_app_store/core/cloud_storage/resources.dart';
import 'package:fusion_app_store/core/global/ui_utils.dart';
import 'package:fusion_app_store/core/injection/injector.dart';
import 'package:fusion_app_store/core/routing/route_service.dart';
import 'package:fusion_app_store/firebase_options.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';

bool debugMode = false;

void main(List<String> args) async {
  debugMode = args.contains('--debug');
  if (debugMode) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
    await Resources.init();
    setPathUrlStrategy();
    return runApp(const App());
  }
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
      await Resources.init();
      return runApp(const App());
    },
    (error, stack) {
      // error
      gotoErrorPage(error.toString(), stack);
    },
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Injector.init();
  }

  @override
  Widget build(BuildContext context) {
    final pages = Get.find<RouteService>().pages;
    return GetMaterialApp(
      title: "Fusion App Store",
      debugShowCheckedModeBanner: false,
      initialRoute: RouteService.homePage,
      defaultTransition: Transition.noTransition,
      unknownRoute: pages[0],
      getPages: pages,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: "Satoshi",
        useMaterial3: true,
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamilyFallback: const ["Sen"],
        tooltipTheme: TooltipThemeData(
          waitDuration: const Duration(milliseconds: 500),
          textStyle: AppTheme.fontSize(14).makeMedium(),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.buttonBorder),
          ),
        ),
      ),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context),
          child: ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1200, name: DESKTOP),
              const Breakpoint(start: 1201, end: 1920, name: '2K'),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          ),
        );
      },
    );
  }
}
