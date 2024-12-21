
import 'package:geeks_service/geeks_service.dart';
import 'package:geeks_service/service/logger.dart';

import '../utils/local_storage/storage_service.dart';
import 'route_name.dart';


final StorageService _storage = StorageService();
const _secureStorage = FlutterSecureStorage();
mixin RedirectRouteService {
  // String? token;

  // void getToken() async {
  //   token = await _secureStorage.read(key: 'token');
  //   logger.d(token, 'from cubit');
  // }

  // static Future<bool> authS() async {
  //   final authBox = _storage.getAuthBox();

  //   final authS = authBox.get(StorageH.authKey);

  //   final token = await _secureStorage.read(key: 'token');

  //   final unAuth =
  //       authS == null || authS == false || token == null || token.isEmpty;

  //   logger.d(unAuth);

  //   return !unAuth;
  // }

  static String redirectRoute() {
    String route = '';
   
    final authBox = _storage.getAuthBox();
    // final userTokenBox = _storage.getuserTokenBox();

    final authS = authBox.get(StorageH.authKey);

    // final token = userTokenBox.get(StorageH.userTokenKey);

    // final unAuth =
    //     authS == null || authS == false || token == null || token.isEmpty;

    switch (authS) {
      case null:
        route = '/${RouteName.login}';
        break;
      case false:
        route = '/${RouteName.login}';
        break;
      case true:
        _secureStorage.read(key: 'token').then(
          (value) {
            if (value == null) {
              route = '/${RouteName.login}';
            }
          },
        );
        // logger.d(token, 'from cubit');
        // token == null
        //     ? '/${RouteName.beforeAuth}'
        //     : 
        route = '/${RouteName.homePage}';
        // route = '/${RouteName.mainLayer}';
        break;
    }
    logger.d(authS, 'from cubit');
    logger.d(route, 'from cubit');

    return route;
  }
}

// Future<bool> authState() async {
//   final authS = authBox.get(StorageH.authKey);

//   final token = await _secureStorage.read(key: 'token');

//   final unAuth =
//       authS == null || authS == false || token == null || token.isEmpty;
//   return unAuth;
// }
// class AuthGuard extends AutoRouteGuard {
//   final authBox = _storage.getAuthBox();

//   Future<bool> authState() async {
//     final authS = authBox.get(StorageH.authKey);

//     final token = await _secureStorage.read(key: 'token');

//     final unAuth =
//         authS == null || authS == false || token == null || token.isEmpty;
//     return unAuth;
//   }

//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) async {
//     // the navigation is paused until resolver.next() is called with either
//     // true to resume/continue navigation or false to abort navigation
//     final authS = await authState();
//     if (authS == false) {
//       // if user is authenticated we continue
//       resolver.next(true);
//     } else {
//       // we redirect the user to our login page
//       router.pushAndPopUntil(
//         AuthRoute(),
//         predicate: (route) => false,
//       );
//     }
//   }
// }
