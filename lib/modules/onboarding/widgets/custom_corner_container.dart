import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/functions.dart';
import '../cubits/onboarding_cubit/onboarding_cubit.dart';

enum BorderCorner {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
}

class CustomCornerContainer extends StatelessWidget {
  final BorderCorner corner;

  const CustomCornerContainer({
    super.key,
    required this.corner,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Container(
          width: 75.w,
          height: 28.h,
          decoration: BoxDecoration(
              borderRadius: chooseBorderRadius(corner: corner),
              color: Colors.transparent,
              border: chooseBorderCornerForNextButton(
                  corner: corner, cubit: context.read<OnboardingCubit>())),
          child: const SizedBox(),
        );
      },
    );
  }
}