// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components.dart';
import '../../../resources/colors_manager.dart';
import '../widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return
        const StatusBarChangedWidget(
          statusBarColor: ColorsManager.trans,
          widget: Scaffold(
            body: RegisterViewBody(),
          ),
          // ),
    );
  }
}
