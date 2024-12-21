import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:location/location.dart';

import './root/app_root.dart';
import 'core/notifications/local_notification_service.dart';
import 'firebase_options.dart';
import 'root/bootstrap.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

var box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  box = await Hive.openBox('positionBox');
  await Location().getLocation().then((value) {
    box.put("lat", value.latitude);
    box.put("lng", value.longitude);
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await LocalNotificationService.initialize();

  bootstrap(() => const AppRoot());
}

// Firebase Initialize ..
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  logger.i(message.notification);
  logger.i('${message.data}', 'Notification Message');

  await LocalNotificationService.showNotification(message);
}
