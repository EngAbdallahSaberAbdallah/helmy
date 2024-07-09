import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:helmy_project/app/components.dart';
import '../cubits/plans_cubit/cubit/plans_cubit.dart';
import '../controller/dream_controller.dart';
import '../model/plans_model.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SelectPaymentGetway extends StatefulWidget {
  SelectPaymentGetway({super.key});

  @override
  State<SelectPaymentGetway> createState() => _SelectPaymentGetwayState();
}

class _SelectPaymentGetwayState extends State<SelectPaymentGetway> {
  final DreamController dreamController = Get.find<DreamController>();

  String planName = '';

  Widget _drawPlan({required PlanModel plan}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorsManager.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: ExpansionTile(
        title: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  planName = plan.name!.ar.toString();
                });
                dreamController.planId.value = plan.id!;
                dreamController.hasSeletedPlan.value = true;
              },
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorsManager.white, width: 1.5),
                  ),
                  child: planName == plan.name!.ar
                      ? Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                              color: ColorsManager.primaryDarkPurple,
                              shape: BoxShape.circle),
                        )
                      : const SizedBox.shrink()),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              plan.name!.ar.toString(),
              style: getRegularStyle(
                  color: ColorsManager.primaryDarkPurple,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        backgroundColor: ColorsManager.cardColor,
        iconColor: ColorsManager.buttonDarkColor,
        collapsedIconColor: ColorsManager.buttonDarkColor,
        trailing: Image.asset(
          AssetsManager.arrowDown,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        expandedAlignment: Alignment.topRight,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 4.h),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  HtmlWidget(
                    plan.description!.ar!,
                    textStyle: getRegularStyle(
                        color: ColorsManager.primaryDarkPurple,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  // Text(
                  //   plan.description!.ar!,
                  //   // maxLines: 2,
                  //   style: getRegularStyle(
                  //       color: ColorsManager.primaryDarkPurple,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.w300),
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Text(
                  plan.price.toString(),
                  style: getRegularStyle(
                      color: ColorsManager.primaryDarkPurple,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                Text(tr(StringsManager.egyptPound),
                    style: getRegularStyle(
                        color: ColorsManager.primaryDarkPurple,
                        fontSize: 15,
                        fontWeight: FontWeight.w700))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PlansCubit>(context).getAllPlans();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          child: BlocBuilder<PlansCubit, PlansState>(builder: (context, state) {
            if (state is PlansLoading) {
              return Transform.translate(
                offset: const Offset(0, -200),
                child: const Center(child: Loading()),
              );
            } else if (state is PlansLoaded) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: state.plans.length,
                itemBuilder: (context, index) => _drawPlan(
                  plan: state.plans[index],
                ),
              );
            }
            return const SizedBox();
          }),
        ));
  }
}
