import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/icons_manager.dart';
import 'package:helmy_project/resources/values_manager.dart';
import '../cubits/bottom_nav_bar_cubit.dart';

class BadgesWidget extends StatelessWidget {
  const BadgesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterpreterBottomNavBarCubit, InterpreterBottomNavBarState>(
      builder: (context, state) {
        var cubit = context.read<InterpreterBottomNavBarCubit>();
        return badges.Badge(
          position: badges.BadgePosition.custom(isCenter: false, top: -8),
          showBadge: true,
          ignorePointer: false,
          onTap: () {
            cubit.changeBottomNavIndex(4);
          },
          badgeContent: Text(
            '3',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: AppSize.s11, color: ColorsManager.primaryBgDark),
          ),
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.circle,
            badgeColor: ColorsManager.primaryDarkPurple,
            borderSide: BorderSide(
                color: cubit.bottomNavigationBarCurrentIndex == AppSize.s4
                    ? ColorsManager.primaryTxt1OffWhite
                    : ColorsManager.primaryDarkPurple,
                width: AppSize.s1),
            padding: const EdgeInsets.all(AppSize.s4),
            borderRadius: BorderRadius.circular(AppSize.s4),
          ),
          child: const Icon(Tqneen.notification),
        );
      },
    );
  }
}
