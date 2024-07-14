import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/components.dart';
import '../controller/dream_controller.dart';
import 'recorder_widget.dart';
import 'spacer_height.dart';
import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class InfoDream extends StatefulWidget {
  const InfoDream({super.key});

  @override
  State<InfoDream> createState() => _InfoDreamState();
}

class _InfoDreamState extends State<InfoDream> {
  final TextEditingController _dreamNameController = TextEditingController();
  final TextEditingController _dreamDescriptionController =
      TextEditingController();

  final DreamController dreamController = Get.find<DreamController>();

  bool isClickedBtn = false;

  @override
  void dispose() {
    _dreamNameController.dispose();
    _dreamDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForm();
  }

  Widget _buildForm() {
    return SingleChildScrollView(
        child: Form(
      key: dreamController.formKeyInfoDreamData,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDreamNameField(),
          const SpacerHeight(),
          _buildContentText(text: tr(StringsManager.addDreamContent)),
          const SpacerHeight(),
          _buildDreamDetailsField(),
          const SpacerHeight(),
          _buildContentText(text: tr(StringsManager.recorderContent)),
          const SpacerHeight(),
          _recorderBtn(),
        ],
      ),
    ));
  }

  Widget _buildContentText({required String text}) {
    return Text(
      text,
      style: getRegularStyle(
          color: ColorsManager.primaryDarkPurple,
          fontSize: 15,
          fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDreamNameField() {
    return CustomTextFormField(
        controller: _dreamNameController,
        hint: tr(StringsManager.enterDreamName),
        onChanged: (value) {
          dreamController.title.value = value!;
        },
        validator: (value) {
          if (value!.isEmpty) {
            return tr(StringsManager.enterDreamName);
          }
          return null;
        },
        sufixIconBackground: ColorsManager.white,
        borderColor: ColorsManager.primaryDarkPurple,
        heightOfTextFormField: 54);
  }

  Widget _buildDreamDetailsField() {
    return SizedBox(
      height: 290.sp,
      child: CustomTextAreaFormField(
          controller: _dreamDescriptionController,
          hint: "تفاصيل الحلم",
          onChanged: (value) {
            dreamController.description.value = value!;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return tr(StringsManager.addDreamContent);
            }
            return null;
          },
          sufixIconBackground: ColorsManager.white,
          borderColor: ColorsManager.primaryDarkPurple,
          heightOfTextFormField: 304),
    );
  }

  Widget _recorderBtn() {
    return const RecorderExample();
  }
}
