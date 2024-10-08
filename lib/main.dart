import 'package:bloc/bloc.dart';
import 'package:dawaa24/core/services/notification_handler.dart';
import 'package:dawaa24/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*import 'package:flutter_stripe/flutter_stripe.dart';*/

import 'app.dart';
import 'core/data/constants/shared_constants_class.dart';
import 'core/utils/app_bloc_observer.dart';
import 'di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebaseApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await configureInjection();
  // await configureStripe();
  await EasyLocalization.ensureInitialized();

  /// load google maps dark styling string here to be used anywhere in the app without any delay !
  SharedConstantsClass.googleMapDarkStyleString =
      await rootBundle.loadString('assets/google_maps_styles/dark.json');

  getIt<NotificationHandler>()
    ..listenForReceivedNotification()
    ..listenForSelectedNotification();

  Bloc.observer = AppBlocObserver();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: App()),
  );
}

Future<void> initFirebaseApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

/*

configureStripe() async {
  Stripe.publishableKey = AppConstant.testPublishKey;
  // Stripe.publishableKey = AppConstant.publishKey;
  Stripe.merchantIdentifier = AppConstant.stripeMerchantId;
  Stripe.urlScheme = 'flutterstripe';

  await Stripe.instance.applySettings();
}
*/
