import 'dart:async';
import 'dart:io';

import 'package:helmy_project/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class AppExceptions {
  static final Exception defaultException = Exception(tr(StringsManager.somethingWentWrong));
  static final Exception authorizationException =
      Exception(tr(StringsManager.unauthorizedUser));
  static final Exception timeOutException =
      TimeoutException(tr(StringsManager.requestTimeout));
  static final Exception parsingException = Exception(tr(StringsManager.errorParsingData));
  static final Exception internalServerError =
      Exception(tr(StringsManager.internalServerError));
  static final SocketException networkError =
      SocketException(tr(StringsManager.networkConnectionError));

  static List allExceptions = [
    defaultException,
    authorizationException,
    timeOutException,
    parsingException,
    internalServerError,
    networkError
  ];
}
