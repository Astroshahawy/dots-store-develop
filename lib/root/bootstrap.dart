import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../core/utils/assets_file.dart';
import '../core/utils/local_control.dart';
import '../injection/initial_file.dart';
import 'app_bloc_observer.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // await runZonedGuarded(
    // () async {/
      await Hive.initFlutter();
      await InitialFile().call();

      Bloc.observer = AppBlocObserver();
      runApp(
        EasyLocalization(
          path: AssetsFile.l10n,
          supportedLocales: LocalControl.supportLocal,
          startLocale: LocalControl.localAr,
          fallbackLocale: LocalControl.localAr,
          child: await builder(),
        ),
      );
    // },
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}
