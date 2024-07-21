import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/components.dart';
import '../../../start/views/drawer_view.dart';
import '../../../start/widgets/build_app_bar.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/colors_manager.dart';
import '../cubits/interpreter_bottom_nav_bar_cubit.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class InterpreterStartView extends StatefulWidget {
  const InterpreterStartView({super.key});

  @override
  State<InterpreterStartView> createState() => _InterpreterStartViewState();
}

class _InterpreterStartViewState extends State<InterpreterStartView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
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
        BlocBuilder<InterpreterBottomNavBarCubit, InterpreterBottomNavBarState>(
      builder: (navContext, state) {
        InterpreterBottomNavBarCubit navBarCubit =
            navContext.read<InterpreterBottomNavBarCubit>();
        return StatusBarChangedWidget(
          statusBarColor: ColorsManager.trans,
          widget: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            drawer: const DrawerView(),
            body: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  BuildAppBar(
                    title: navBarCubit
                        .titles[navBarCubit.bottomNavigationBarCurrentIndex],
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
                height: 83.sp,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                child: BottomNavBarWidget(navBarCubit: navBarCubit)),
          ),
        );
      },
    );
  }
}
