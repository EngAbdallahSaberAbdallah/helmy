import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'build_header_image.dart';
import 'header_sub_title_text.dart';
import '../../../resources/assets_manager.dart';
import 'termsConditions.dart';
import 'register_button_widget.dart';
import 'register_fill_name_row.dart';
import '../../../resources/colors_manager.dart';

import '../../../app/components.dart';
import '../../../helpers/validation.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../cubits/get_cities_cubit/get_cities_cubit.dart';
import 'gavernorate_and_city_widgets.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({
    super.key,
  });

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  TextEditingController? rFirstNameController = TextEditingController();
  TextEditingController? rLastNameController = TextEditingController();
  TextEditingController? rEmailController = TextEditingController();
  TextEditingController? rPhoneController = TextEditingController();
  TextEditingController? rAddressController = TextEditingController();
  TextEditingController? rPassController = TextEditingController();
  TextEditingController? rConfirmPassController = TextEditingController();
  TextEditingController? rCountryIdController = TextEditingController();

  bool isChecked = false;
  final registerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<GetCitiesCubit>().getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormKey,
      child: PullToFetchDataScreen(
        onRefresh: () async {
          context.read<GetCitiesCubit>().getCities();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeaderImage(),
            _buildContentText(),
            SizedBox(
              height: 15.sp,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegisterFillNameRow(
                    firstController: rFirstNameController,
                    lastController: rLastNameController,
                  ),
                  specificSpacer(),
                  CustomTextFormField(
                    hint: tr(StringsManager.enterEmail),
                    heightOfTextFormField: 51,
                    textInputType: TextInputType.emailAddress,
                    controller: rEmailController,
                    borderColor: ColorsManager.borderGrey,
                    onChanged: (value) {
                      print('value is $value');
                    },
                    formatter: [
                      FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                    ],
                    validator: (value) => value!.isEmpty
                        ? null
                        : ValidationHelper.validateEmail(context, value),
                    sufixIconBackground: Theme.of(context).dividerColor,
                  ),
                  specificSpacer(),
                  CustomTextFormField(
                    hint: tr(StringsManager.phoneNumber),
                    heightOfTextFormField: 51,
                    textInputType: TextInputType.number,
                    controller: rPhoneController,
                    borderColor: ColorsManager.borderGrey,
                    onChanged: (value) {
                      print('value is $value');
                    },
                    validator: (value) => value!.isEmpty
                        ? null
                        : ValidationHelper.validatePhone(context, value),
                    sufixIconBackground: Theme.of(context).dividerColor,
                  ),
                  specificSpacer(),
                  CityAndAreaRow(countryIdController: rCountryIdController!),
                  specificSpacer(),
                  CustomSecureTextFormField(
                    hint: tr(StringsManager.enterPassword),
                    controller: rPassController,
                    validator: (password) =>
                        ValidationHelper.validatePassword(context, password),
                  ),
                  specificSpacer(),
                  CustomSecureTextFormField(
                    controller: rConfirmPassController,
                    hint: tr(StringsManager.confirmPassword),
                    validator: (value) =>
                        ValidationHelper.validateConfirmPassword(
                            rPassController!.text, value!, context),
                  ),
                  _buildTermsConditionsBtn(),
                  //  specificSpacer(),
                  RegisterButtonWidget(
                    registerFormKey: registerFormKey,
                    isCheckedTerms: isChecked,
                    rAddressController: rAddressController,
                    rConfirmPassController: rConfirmPassController,
                    rEmailController: rEmailController,
                    rFirstNameController: rFirstNameController,
                    rLastNameController: rLastNameController,
                    rPassController: rPassController,
                    rPhoneController: rPhoneController,
                  ),
                  specificSpacer(),
                  Center(
                    child: OnTabText(
                      textColor: ColorsManager.primaryDarkPurple,
                      text: tr(StringsManager.alreadyHaveAccount),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w700,
                      onTab: () => Get.offAllNamed(HelmyRoutes.loginRoute),
                    ),
                  ),
                  specificSpacer(),
                  specificSpacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget specificSpacer() {
    return SizedBox(
      height: 8.sp,
    );
  }

  Widget _buildHeaderImage() {
    return BuildHeaderImage(imgPath: AssetsManager.login, height: 260.sp);
  }

  Widget _buildContentText() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: HeaderSubTitleText(
            header: tr(StringsManager.welcome),
            subTitle: tr(StringsManager.signUpContent)));
  }

  Widget _buildTermsConditionsBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value!;
                });
              },
              side: const BorderSide(
                color: ColorsManager.primaryDarkPurple,
                width: 1.5,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              checkColor: Colors.white,
              activeColor: ColorsManager.primaryDarkPurple),
        ),
        const SizedBox(
          width: 10,
        ),
        OptionalText(
            text: '${tr(StringsManager.doYouAgree)} ',
            textColor: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        // const SizedBox(width: 5,),
        const TermsConditions(),
      ],
    );
  }

  @override
  void dispose() {
    rFirstNameController?.dispose();
    rPassController?.dispose();
    rConfirmPassController?.dispose();
    rAddressController?.dispose();
    rEmailController?.dispose();
    rLastNameController?.dispose();
    rPhoneController?.dispose();
    rCountryIdController?.dispose();
    super.dispose();
  }
}
