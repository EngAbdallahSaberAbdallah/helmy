import 'package:flutter/material.dart';
import 'package:helmy_project/app/components.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Loading(),
      ),
    );
  }
}
