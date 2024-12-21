import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geeks_service/service/logger.dart';

import 'local_notification_service.dart';

void fcmHandleMessages() async {
  String? fcmToken = '';
  if (Platform.isAndroid) {
    fcmToken = await FirebaseMessaging.instance.getToken();
  } else if (Platform.isIOS) {
    fcmToken = await FirebaseMessaging.instance.getAPNSToken();
  }

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    logger.i(message.data, 'ON MESSAGE');
    logger.wtf(fcmToken, 'fcmToken');
    LocalNotificationService.showNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    logger.i(message, 'OPEN APP');
    LocalNotificationService.showNotification(message);
  });

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
    logger.i(message, 'BACKGROUND');
    await LocalNotificationService.showNotification(message);
  });
}
