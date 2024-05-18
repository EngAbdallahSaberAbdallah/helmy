import 'dart:io';

import 'package:helmy_project/resources/assets_manager.dart';

import 'exception_widget.dart';
import 'exceptions.dart';
import 'package:flutter/material.dart';

class ExceptionHandler {
  static Widget getExceptionWidget(Object e, void Function() onRetry) {
    return ExceptionWidget(_getExceptionType(e), _getExceptionImage(e),
        onRetry: onRetry);
  }

  static String getExceptionMessage(Object e) => _getExceptionType(e)
      .toString()
      .substring(_getExceptionType(e).toString().indexOf(':') + 1);

  static Object _getExceptionType(e) {
    try {
      print(e);
      if (e is FormatException || e is TypeError) {
        return AppExceptions.parsingException;
      } else if (e is SocketException) {
        return AppExceptions.networkError;
      } else if (e.toString() == 'Instance of \'ExceptionMessage\'') {
        return e;
      }
    } catch (_) {
      return e;
    }
    return e;
  }

  static String _getExceptionImage(Object e) {
    if (e is SocketException) {
      return AssetsManager.noInternet;
    }
    return AssetsManager.error;
  }
}
