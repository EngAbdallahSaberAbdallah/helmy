import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:helmy_project/resources/assets_manager.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Image.asset(AssetsManager.error, height: 80),
      content: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          error,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            tr('ok'),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
