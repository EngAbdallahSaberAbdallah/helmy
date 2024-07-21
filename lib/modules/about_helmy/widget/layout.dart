import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../start/views/drawer_view.dart';
import '../../interpreter/start/widgets/build_app_bar.dart';
import '../../../resources/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../resources/strings_manager.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;
  final String appBarTitle;
  ScreenLayout({super.key, required this.child, required this.appBarTitle});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        drawer: const DrawerView(),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildAppBarInterpreter(
                          title: appBarTitle,
                          imgAccountPath: AssetsManager.accountImage,
                          iconPath: AssetsManager.menu,
                          onPressedIcon: () => Get.back()),
                      SizedBox(
                        height: 24.sp,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 175.sp,
                            child: SingleChildScrollView(child: child)))
                    ]))));
  }
}
