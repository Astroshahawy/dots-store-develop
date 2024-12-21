// Copyright (c) 2022, Geeks-Code. All rights reserved.
// https://geeks-code.com

import 'package:dots/providers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geeks_theme/geeks_theme.dart';
import 'package:get/get.dart';

// import '../core/notifications/fcm_service.dart';
import '../core/route/app_router.dart';
import '../core/route/redirect_route.dart';
import '../injection/injection_container.dart';
// import '../l10n/locale_keys.g.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);
  // final ApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: GeeksThemeProvider(
        themeDataProvider: injector.get<GeeksTheme>(),
        child: const AppRootView(),
      ),
    );
  }
}

class AppRootView extends StatefulWidget  {
  const AppRootView({Key? key}) : super(key: key);

  @override
  State<AppRootView> createState() => _AppRootViewState();
}

class _AppRootViewState extends State<AppRootView> {
  // final ApiClient apiClient;
    @override
  void initState() {
    super.initState();
    // fcmHandleMessages();
  }
  @override
  Widget build(BuildContext context) {
    // final isArabic =
    //     EasyLocalization.of(context)?.currentLocale == LocalControl.localAr;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: LocaleKeys.appTitle.tr(),
      // routerConfig: MyRouter.router,
      locale: context.locale,
      darkTheme: context.readTheme().themeDataProvider.darkTheme,
      theme: context.readTheme().themeDataProvider.lightTheme,
      themeMode: context.readTheme().currentThemeMode,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: RedirectRouteService.redirectRoute(),
      // onGenerateInitialRoutes: (initialRoute) {
        
      // },
      // routeInformationParser: MyRouter.router.routeInformationParser,
      // routerDelegate: MyRouter.router.routerDelegate,
    );
  }
}
