import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helmy_project/helpers/getx_controllers.dart';
import 'app/app.dart';
import 'helpers/bloc_observer.dart';
import 'helpers/languages_helper.dart';
import 'helpers/services_locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  GetXControllers.putControllers();

  Bloc.observer = MyBlocObserver();
  ServicesLocator().init();

  runApp(EasyLocalization(
      startLocale: const Locale('ar'),
      supportedLocales: const [arabicLocale],
      fallbackLocale: const Locale('ar'),
      path: localizationPath,
      child: const HelmyApp()));
}