import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app/functions.dart';
import '../../../resources/values_manager.dart';

class MyDreamsShimmer extends StatelessWidget {
  const MyDreamsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Container(
                width: calcWidth(51, context),
                height: calcHeight(51, context),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s6)),
              ),
              const SizedBox(
                width: 13,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: AppSize.s16,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Container(
                      width: double.infinity,
                      height: AppSize.s16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: calcHeight(8, context),
          ),
          _buildRowWithTitleAndSubTitle(context),
          SizedBox(
            height: calcHeight(8, context),
          ),
          _buildRowWithTitleAndSubTitle(context),
          SizedBox(
            height: calcHeight(8, context),
          ),
          _buildRowWithTitleAndSubTitle(context),
          SizedBox(
            height: calcHeight(8, context),
          ),
          _buildRowWithTitleAndSubTitle(context),
          SizedBox(
            height: calcHeight(8, context),
          ),
          _buildRowWithTitleAndSubTitle(context),
        ],
      ),
    );
  }

  Widget _buildRowWithTitleAndSubTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: calcHeight(20, context),
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: AppSize.s5,
        ),
        Expanded(
          child: Container(
            height: calcHeight(20, context),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}