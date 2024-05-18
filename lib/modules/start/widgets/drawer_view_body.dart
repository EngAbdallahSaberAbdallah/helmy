import 'package:flutter/material.dart';

import 'drawer_app_bar.dart';
import 'drawer_buttons_list_view.dart';

class DrawerViewBody extends StatelessWidget {
  const DrawerViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // DrawerAppBar(),
          DrawerButtonsListView(),
        ],
      ),
    );
  }
}
