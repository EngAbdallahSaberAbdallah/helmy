import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static void showErrorSnackBar(String title, String message) {
    Get.showSnackbar(GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.red,
    ));
  }

  static void showSuccessSnackBar(String title, String message) {
    Get.showSnackbar(GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green));
  }
}