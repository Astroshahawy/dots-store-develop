// import 'package:dots/app/features/give_meal/views/pages/give_meal_page.dart';
// import 'package:dots/app/features/home/views/pages/home_page.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geeks_service/service/logger.dart';
// import 'package:go_router/go_router.dart';

// import '../../app/features/add_employee/views/page/add_employee.dart';
// import '../../app/features/add_employee/views/page/employees_page.dart';
// import '../../app/features/auth/logic/blocs/redirect_cubit/redirect_cubit.dart';
// import '../../app/features/auth/views/pages/login_page.dart';
// import '../../app/features/contact_us/views/pages/contact_us_page.dart';
// import '../../app/features/give_user/views/pages/cash_back_page.dart';
// import '../../app/features/give_user/views/pages/give_points_page.dart';
// import '../../app/features/invoice/views/pages/invoice_page.dart';
// import '../../app/features/notifications/page/notification_page.dart';
// import '../../app/features/offer_packages/views/pages/offer_packages_page.dart';
// import '../../app/features/package/views/pages/package.dart';
// import '../../app/features/static_pages/views/pages/how_to_use_page.dart';
// import '../../app/features/static_pages/views/pages/privacy_policy_page.dart';
// import '../../app/features/support_center/views/pages/support_center_page.dart';

import 'package:dots/app/features/auth/views/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../../app/features/add_employee/views/page/add_employee.dart';
import '../../app/features/add_employee/views/page/employees_page.dart';
import '../../app/features/contact_us/views/pages/contact_us_page.dart';
import '../../app/features/give_meal/views/pages/give_meal_page.dart';
import '../../app/features/give_user/views/pages/cash_back_page.dart';
import '../../app/features/give_user/views/pages/give_points_page.dart';
import '../../app/features/home/views/pages/home_page.dart';
import '../../app/features/invoice/views/pages/invoice_page.dart';
import '../../app/features/notifications/page/notification_page.dart';
import '../../app/features/offer_packages/views/pages/offer_packages_page.dart';
import '../../app/features/package/views/pages/package.dart';
import '../../app/features/static_pages/views/pages/how_to_use_page.dart';
import '../../app/features/static_pages/views/pages/privacy_policy_page.dart';
import '../../app/features/support_center/views/pages/support_center_page.dart';
import 'route_name.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/${RouteName.homePage}':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/${RouteName.awardPoints}':
        return MaterialPageRoute(builder: (_) => const GivePointsPage());
      case '/${RouteName.invoicePage}':
        return MaterialPageRoute(builder: (_) => const InvoicePage());
      case '/${RouteName.cashback}':
        return MaterialPageRoute(builder: (_) => const CashbackPage());
      case '/${RouteName.giveMeal}':
        return MaterialPageRoute(builder: (_) => const GiveMealPage());
      case '/${RouteName.offerPackagesPage}':
        return MaterialPageRoute(builder: (_) => const OfferPackagesPage());
      case '/${RouteName.packagesPage}':
        return MaterialPageRoute(builder: (_) => const SubscribePackages());
      case '/${RouteName.supportCenter}':
        return MaterialPageRoute(builder: (_) => const SupportCenterPage());
      case '/${RouteName.contactUs}':
        return MaterialPageRoute(builder: (_) => const ContactUsPage());
      case '/${RouteName.howToUse}':
        return MaterialPageRoute(builder: (_) => const HowToUsePage());
      case '/${RouteName.privacyPolicyPage}':
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyPage());
      case '/${RouteName.employeesPage}':
        return MaterialPageRoute(builder: (_) => const EmployeesPage());
      case '/${RouteName.addEmployee}':
        return MaterialPageRoute(builder: (_) => const AddEmployeePage());
      case '/${RouteName.notificationPage}':
        return MaterialPageRoute(builder: (_) => const NotificationPage());
      case '/${RouteName.login}':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // case '/${RouteName.phoneVerification}':
      // return MaterialPageRoute(builder: (_) => const PinCodeScreen());
      // case '/${}':
      // return MaterialPageRoute(builder: (_) =>const ());
      default:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );
    }
  }
} 


// onGenerateInitialRoutes: (navigatorState, initialRoute) {
//         if (initialRoute == '/deepLink') {
//             return [MaterialPageRoute(builder: (context) => const DeepLinkScreen())]
//         }
//         else {
//             // This is NOW possible
//             return Navigator.defaultGenerateInitialRoutes(navigatorState, initialRoute);
//         }
//     }

//-------------------------------------------------------------------------
// const _pageKey = ValueKey('_pageKey');
// // /..

// class MyRouter {
//   static final router = GoRouter(
//     initialLocation: '/${RouteName.login}',
//     debugLogDiagnostics: kDebugMode ? true : false,
//     // urlPathStrategy: UrlPathStrategy.path,
//     routes: routes,
//     errorBuilder: (context, state) => ErrorView(state.error!),
//     redirect: (BuildContext ctx, GoRouterState state) async {
//       final authCu = ctx.read<RedirectCubit>();
//       final unAuth = await authCu.unAuthS;
//       logger.d(unAuth, 'from Router');
//       final bool loggingIn = state.subloc == '/${RouteName.login}';
//       if (unAuth) {
//         return loggingIn ? null : '/${RouteName.login}';
//       }
//       if (loggingIn) {
//         return '/${RouteName.homePage}';
//       }
//       return null;
//     },
//   );

//   static List<GoRoute> routes = [
//     GoRoute(
//       name: RouteName.homePage,
//       path: '/${RouteName.homePage}',
//       pageBuilder: (context, state) => const MaterialPage<void>(
//         key: _pageKey,
//         child: HomePage(),
//       ),
//       routes: [
//         GoRoute(
//           name: RouteName.awardPoints,
//           path: RouteName.awardPoints,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: GivePointsPage(),
//           ),
//         ),
//         GoRoute(
//           name: RouteName.invoicePage,
//           path: RouteName.invoicePage,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const InvoicePage(),
//           ),
//         ),
//         GoRoute(
//           name: RouteName.cashback,
//           path: RouteName.cashback,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: CashbackPage(),
//           ),
//         ),
//         GoRoute(
//           name: RouteName.giveMeal,
//           path: RouteName.giveMeal,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const GiveMealPage(),
//           ),
//         ),
//         GoRoute(
//           name: RouteName.offerPackagesPage,
//           path: RouteName.offerPackagesPage,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const OfferPackagesPage(),
//           ),
//         ),
//         GoRoute(
//           name: RouteName.packagesPage,
//           path: RouteName.packagesPage,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const SubscribePackages(),
//           ),
//         ),

//         ///* supportCenter
//         GoRoute(
//           name: RouteName.supportCenter,
//           path: RouteName.supportCenter,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const SupportCenterPage(),
//           ),
//         ),

//         ///* contactUs
//         GoRoute(
//           name: RouteName.contactUs,
//           path: RouteName.contactUs,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const ContactUsPage(),
//           ),
//         ),

//         ///* howToUse
//         GoRoute(
//           name: RouteName.howToUse,
//           path: RouteName.howToUse,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const HowToUsePage(),
//           ),
//         ),

//         GoRoute(
//           name: RouteName.privacyPolicyPage,
//           path: RouteName.privacyPolicyPage,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const PrivacyPolicyPage(),
//           ),
//         ),

//         GoRoute(
//           name: RouteName.employeesPage,
//           path: RouteName.employeesPage,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const EmployeesPage(),
//           ),
//           routes: [
//             GoRoute(
//               name: RouteName.addEmployee,
//               path: RouteName.addEmployee,
//               pageBuilder: (context, state) => MaterialPage<void>(
//                 key: state.pageKey,
//                 child: const AddEmployeePage(),
//               ),
//             ),
//           ],
//         ),
//         GoRoute(
//           name: RouteName.notificationPage,
//           path: RouteName.notificationPage,
//           pageBuilder: (context, state) => MaterialPage<void>(
//             key: state.pageKey,
//             child: const NotificationPage(),
//           ),
//         ),
//       ],
//     ),

//     ///* Auth

//     ///*
//     GoRoute(
//       name: RouteName.login,
//       path: '/${RouteName.login}',
//       pageBuilder: (context, state) => const MaterialPage<void>(
//         key: _pageKey,
//         child: LoginPage(),
//       ),
//     ),
//   ];
// }

// class RouteModel {
//   const RouteModel({
//     required this.key,
//     required this.name,
//     required this.path,
//     required this.child,
//   });
//   final Key key;
//   final String name;
//   final String path;
//   final Widget child;
// }

// class ErrorScaffold extends StatelessWidget {
//   const ErrorScaffold({
//     required this.body,
//     Key? key,
//   }) : super(key: key);

//   final Widget body;
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(title: const Text('Page Not Found')),
//         body: body,
//       );
// }

// class ErrorView extends StatelessWidget {
//   const ErrorView(this.error, {Key? key}) : super(key: key);
//   final Exception error;

//   @override
//   Widget build(BuildContext context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SelectableText(error.toString()),
//             TextButton(
//               onPressed: () => context.go('/'),
//               child: const Text('Home'),
//             ),
//           ],
//         ),
//       );
// }
