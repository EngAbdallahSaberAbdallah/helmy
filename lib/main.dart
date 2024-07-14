import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'helpers/getx_controllers.dart';
import 'app/app.dart';
import 'helpers/bloc_observer.dart';
import 'helpers/languages_helper.dart';
import 'helpers/services_locator.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  GetXControllers.putControllers();

  Bloc.observer = MyBlocObserver();
  ServicesLocator().init();

  runApp(
      //  SocialAuth()
      EasyLocalization(
          startLocale: const Locale('ar'),
          supportedLocales: const [arabicLocale],
          fallbackLocale: const Locale('ar'),
          path: localizationPath,
          child: const HelmyApp()));
}
