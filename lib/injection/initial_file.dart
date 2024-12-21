import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeks_service/service/logger.dart';
import 'package:geeks_theme/theme/theme_initialize.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/notifications/local_notification_service.dart';
import '../core/utils/local_storage/local_storage.dart';
import '../core/utils/local_storage/storage_service.dart';
import '../firebase_options.dart';
import 'injection_container.dart';

class InitialFile {
  InitialFile() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
      ),
    );
  }
  Future call() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await LocalNotificationService.initialize();

    await EasyLocalization.ensureInitialized();
    await ThemeInitialize.instance;
     await Hive.openBox<bool>(StorageH.authKey);
    await Storage.init();
    await InjectorFile().injectorFile();
  }
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
