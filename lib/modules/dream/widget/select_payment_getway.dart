import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/dream/controller/dream_controller.dart';
import 'package:helmy_project/modules/dream/model/plans.dart';
import 'package:helmy_project/resources/assets_manager.dart';
import 'package:helmy_project/resources/colors_manager.dart';
import 'package:helmy_project/resources/strings_manager.dart';
import 'package:helmy_project/resources/styles_manager.dart';

class SelectPaymentGetway extends StatefulWidget {
  SelectPaymentGetway({super.key});

  @override
  State<SelectPaymentGetway> createState() => _SelectPaymentGetwayState();
}

class _SelectPaymentGetwayState extends State<SelectPaymentGetway> {
  final DreamController dreamController = Get.find<DreamController>();

  String planName = '';
  List<Plans> plans = [];
  final listOfPlans = [
    {
      "id": 1,
      "planName": "VIP",
      "planData": [
        "يتم التفسير خلال 6 ساعات",
        "يشاهد بواسطة المفسر وصاحب الحلم فقط",
        "شرح مفصل للرموز والدلالات",
        "يمكن الرد على المفسر حول الحلم",
        "يمكن تسجيل مقطع صوتى"
      ],
      "price": 300
    },
    {
      "id": 2,
      "planName": "مستعجل",
      "planData": [
        "يتم التفسير خلال 24 ساعات",
        "يشاهد بواسطة المفسر وصاحب الحلم فقط",
        "شرح مفصل للرموز والدلالات",
        "يمكن الرد على المفسر حول الحلم",
        "يمكن تسجيل مقطع صوتى"
      ],
      "price": 250
    },
    {
      "id": 2,
      "planName": "مميز",
      "planData": [
        "يتم التفسير خلال 48 ساعات",
        "شرح مفصل للرموز والدلالات",
        "يمكن الرد على المفسر حول الحلم",
        "يمكن تسجيل مقطع صوتى"
      ],
      "price": 200
    }
  ];

  void getListOfPlans() {
    setState(() {
      plans = listOfPlans.map((e) => Plans.fromJson(e)).toList();
    });
  }

  Widget _drawPlan({required Plans plan}) {
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
                    planName = plan.planName.toString();
                  });
                  dreamController.planId.value = plan.planId!;
                  dreamController.hasSeletedPlan.value = true;
                },
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: ColorsManager.white, width: 1.5),
                    ),
                    child: planName == plan.planName
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
                plan.planName.toString(),
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
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: plan.planData!.length,
                      itemBuilder: (context, index) =>  SizedBox(
                            height: 25,
                            child:Row(
                        children: [
                          Image.asset(
                            AssetsManager.right,
                            width: 19,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 25,
                            child: Text(
                              plan.planData![index],maxLines: 2,
                              style: getRegularStyle(
                                  color: ColorsManager.primaryDarkPurple,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
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
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  void initState() {
    getListOfPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 80,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: plans.length,
            itemBuilder: (context, index) => _drawPlan(
              plan: plans[index],
            ),
          )),
    );
  }
}
