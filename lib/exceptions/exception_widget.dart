import 'package:flutter/material.dart';
import 'package:helmy_project/resources/assets_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(this.exception, this.imagePath,
      {Key? key, required this.onRetry})
      : super(key: key);
  final Object exception;
  final String imagePath;
  final void Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath,
              width: MediaQuery.of(context).size.width * .2,
              fit: BoxFit.cover,
              color: imagePath == AssetsManager.noInternet
                  ? Theme.of(context).primaryColor
                  : null),
          const SizedBox(
            height: 8,
          ),
          Text(
            exception
                .toString()
                .substring(exception.toString().indexOf(':') + 1),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
