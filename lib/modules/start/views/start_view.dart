import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../helpers/cache_helper.dart';
import '../../../helpers/services_locator.dart';
import '../../dream/view/add_dream.dart';
import 'drawer_view.dart';
import '../widgets/build_app_bar.dart';
import '../../../network/network_constants.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

import '../../../app/components.dart';
import '../../../resources/assets_manager.dart';

import '../cubits/bottom_nav_bar_cubit.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _setToken();
  }

  _setToken() async {
    NetworkConstants.token = await getIt.get<CacheHelper>().getToken() ?? '';
    NetworkConstants.isInterpreter =
        await getIt.get<CacheHelper>().getIsInterpreter() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return
        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider(
        //       create: (context) => GetHomeDataCubit(getIt.get())..getHomeData(),
        //     ),
        //   ],
        //   child:
        BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (navContext, state) {
        BottomNavBarCubit navBarCubit = navContext.read<BottomNavBarCubit>();
        return StatusBarChangedWidget(
          statusBarColor: ColorsManager.trans,
          widget: Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
              drawer: const DrawerView(),
              body: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    BuildAppBar(
                      imgAccountPath: AssetsManager.accountImage,
                      iconPath: AssetsManager.menu,
                      onPressedIcon: () =>
                          _scaffoldKey.currentState!.openDrawer(),
                    ),
                    SizedBox(
                      height: 24.sp,
                    ),
                    navBarCubit.homeLayoutScreens[
                        navBarCubit.bottomNavigationBarCurrentIndex],
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: 105.sp,
                color: Colors.transparent,
                child: Stack(alignment: Alignment.bottomCenter, children: [
                  Container(
                      height: 83.sp,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                      ),
                      child: BottomNavBarWidget(navBarCubit: navBarCubit)),
                  Transform.translate(
                    offset: Offset(0, -19.sp),
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => const AddDream());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80.sp,
                              height: 80.sp,
                              decoration: const BoxDecoration(
                                color: ColorsManager.buttonDarkColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: ColorsManager.primaryDarkPurple,
                                  size: 37,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(tr(StringsManager.addDream),
                                style: getRegularStyle(
                                    color: ColorsManager.secondaryBtnBg,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              )),
        );
      },
    );
  }
}
