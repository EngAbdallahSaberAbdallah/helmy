import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:helmy_project/modules/auth/cubits/get_cities_cubit/get_cities_cubit.dart';
import 'package:helmy_project/modules/auth/widgets/gavernorate_and_city_widgets.dart';
import '../../../app/components.dart';
import '../controller/dream_controller.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class InfoDreamOwner extends StatefulWidget {
  const InfoDreamOwner({super.key});

  @override
  State<InfoDreamOwner> createState() => _InfoDreamOwnerState();
}

class _InfoDreamOwnerState extends State<InfoDreamOwner> {
  final TextEditingController _controller = TextEditingController();

  final DreamController dreamController = Get.find<DreamController>();

  String selectMaritalStatus = '';
  final List<String> listMaritalStatus = ['أعزب', 'متزوج'];

  String selectSex = '';
  final List<String> listSex = ['ذكر', "انثي"];

  String selectJob = '';
  final List<String> listJob = ['عامل', "غير عامل"];

  String selectHasChild = '';
  final List<String> listHasChild = ['لا', "نعم"];

  String selectHasIllnesses = '';
  final List<String> listHasIllnesses = ['لا', "نعم"];

  String selectDreamTime = '';
  final List<String> listDreamTime = [
    'بعد صلاة الفجر',
    "بعد صلاة الضهر",
    "بعد صلاة العصر",
    "بعد صلاة المغرب",
    "بعد صلاة العشاء"
  ];

  String selectIstikharaPrayer = '';
  final List<String> listIstikharaPrayer = ['لا', "نعم"];

  @override
  void initState() {
    context.read<GetCitiesCubit>().getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context: context);
  }

  Widget _buildBody({required BuildContext context}) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 100,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              CityAndAreaRow(
                  countryIdController: dreamController.rCountryIdController),
              _spacer(),
              _buildDropDownMenu(
                  title: 'الحالة الإجتماعية',
                  selectedItem: selectMaritalStatus,
                  list: listMaritalStatus,
                  onChanged: (value) {
                    setState(() {
                      selectMaritalStatus = value; // Update the selected value
                      if (value == 'أعزب') {
                        dreamController.maritalStatus.value = 'single';
                      } else {
                        dreamController.maritalStatus.value = 'married';
                      }
                      dreamController.hasSelectedMaritalStatus.value = true;
                    });
                  }),
              _spacer(),
              _buildDropDownMenu(
                  title: 'الجنس',
                  selectedItem: selectSex,
                  list: listSex,
                  onChanged: (value) {
                    setState(() {
                      selectSex = value;
                      if (value == 'ذكر') {
                        dreamController.gender.value = 'male';
                      } else {
                        dreamController.gender.value = 'female';
                      }
                      dreamController.hasSelectedGender.value = true;
                    });
                  }),
              _spacer(),
              _buildTextField(title: 'العمر', subTitle: '26'),
              _spacer(),
              _buildDropDownMenu(
                  title: 'الحالة والظيفية',
                  selectedItem: selectJob,
                  list: listJob,
                  onChanged: (value) {
                    setState(() {
                      selectJob = value;
                      if (value == 'عامل') {
                        dreamController.employed.value = 0;
                      } else {
                        dreamController.employed.value = 1;
                      }
                      dreamController.hasSelectedEmployed.value = true;
                    });
                  }),
              _spacer(),
              _buildDropDownMenu(
                  title: 'هل لديك أطفال ؟',
                  selectedItem: selectHasChild,
                  list: listHasChild,
                  onChanged: (value) {
                    setState(() {
                      selectHasChild = value;
                      if (value == 'لا') {
                        dreamController.haveChildrens.value = 0;
                      } else {
                        dreamController.haveChildrens.value = 1;
                      }
                      dreamController.hasSelectedHaveChildrens.value = true;
                    });
                  }),
              _spacer(),
              _buildDropDownMenu(
                  title: 'هل تعانى من أمراض روحية أو نفسية ؟',
                  selectedItem: selectHasIllnesses,
                  list: listHasIllnesses,
                  onChanged: (value) {
                    setState(() {
                      selectHasIllnesses = value;
                      if (value == 'لا') {
                        dreamController.mentalIllness.value = 0;
                      } else {
                        dreamController.mentalIllness.value = 1;
                      }
                      dreamController.hasSelectedMentalIllness.value = true;
                    });
                  }),
              _spacer(),
              _buildDropDownMenu(
                  title: 'وقت الحلم',
                  selectedItem: selectDreamTime,
                  list: listDreamTime,
                  onChanged: (value) {
                    setState(() {
                      selectDreamTime = value;
                      dreamController.dreamTime.value = value.toString();
                      dreamController.hasSelectedDreamTime.value = true;
                    });
                  }),
              _spacer(),
              _buildDropDownMenu(
                  title: 'هل الحلم كان بعد صلاة إستخارة ؟',
                  selectedItem: selectIstikharaPrayer,
                  list: listIstikharaPrayer,
                  onChanged: (value) {
                    setState(() {
                      selectIstikharaPrayer = value;
                      if (value == 'لا') {
                        dreamController.guidancePrayer.value = 0;
                      } else {
                        dreamController.guidancePrayer.value = 1;
                      }
                      dreamController.hasSelectedGuidancePrayer.value = true;
                    });
                  }),
              const SizedBox(
                height: 20,
              )
            ],
          )),
    );
  }

  Widget _spacer() {
    return const SizedBox(
      height: 12,
    );
  }

  Widget _buildTextField({required String title, required String subTitle}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getRegularStyle(
              color: ColorsManager.primaryDarkPurple,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTextFormField(
            textInputType: TextInputType.number,
            controller: _controller,
            hint: subTitle,
            validator: (value) {
              if (int.parse(value.toString()) < 18) {
                return tr(StringsManager.agebiggerThan18);
              }
            },
            onChanged: (value) {
              if (int.parse(value.toString()) >= 18) {
                dreamController.age.value = value.toString();
                dreamController.hasSelectedAge.value = true;
              }
            },
            sufixIconBackground: Colors.transparent,
            borderColor: ColorsManager.primaryDarkPurple,
            heightOfTextFormField: 54)
      ],
    );
  }

  Widget _buildDropDownMenu(
      {required String title,
      required List<String> list,
      required String selectedItem,
      required Function(String) onChanged}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getRegularStyle(
                color: ColorsManager.primaryDarkPurple,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 54,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: DropdownButton<String>(
              hint: Text(
                "اختر",
                textAlign: TextAlign.start,
                style: getRegularStyle(color: ColorsManager.textShade),
              ),
              value: selectedItem.isNotEmpty ? selectedItem : null,
              padding: EdgeInsets.zero,
              elevation: 0,
              alignment: Alignment.centerRight,
              // hint: Text(
              //   selectedItem,
              //   style: getRegularStyle(color: ColorsManager.textShade),
              // ),
              // disabledHint: Text(
              //   selectedItem,
              //   style: getRegularStyle(color: ColorsManager.textShade),
              // ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              items: list.map((sex) {
                return DropdownMenuItem<String>(
                  alignment: AlignmentDirectional.centerStart,
                  value: sex,
                  child: Text(
                    sex,
                    textAlign: TextAlign.start,
                    style: getRegularStyle(color: ColorsManager.textShade),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                onChanged(value!);
              },
            ),
          )
        ]);
  }
}
