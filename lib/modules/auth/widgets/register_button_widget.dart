import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/otp_view.dart';
import '../../../resources/colors_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app/components.dart';
import '../../../app/functions.dart';
import '../../../resources/strings_manager.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../cubits/get_cities_cubit/get_cities_cubit.dart';
import '../cubits/governorate_and_city_cubit/governorate_and_city_cubit.dart';
import '../models/user_model.dart';

class RegisterButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> registerFormKey;
  final TextEditingController? rFirstNameController;
  final TextEditingController? rLastNameController;
  final TextEditingController? rEmailController;
  final TextEditingController? rPhoneController;
  final TextEditingController? rAddressController;
  final TextEditingController? rPassController;
  final TextEditingController? rConfirmPassController;
  final bool isCheckedTerms;

  const RegisterButtonWidget(
      {super.key,
      required this.registerFormKey,
      this.rFirstNameController,
      this.rLastNameController,
      this.rEmailController,
      this.rPhoneController,
      this.rAddressController,
      this.rPassController,
      this.rConfirmPassController,
      required this.isCheckedTerms});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is RegisterSuccess) {
          String phone = "";
          Navigator.pop(context);
          pushWithRemoveAllRoutes(
              context: context,
              widget: OTPView(
                isReset: false,
                mail: rEmailController!.text,
                isFromRegister: true,
                isCustomer: false,
                isFromLogin: false,
              ));
        }
      },
      builder: (context, state) {
        if (state is! RegisterLoading) {
          return DefaultPrimaryButton(
            textColor: Theme.of(context).primaryColorDark,
            buttonText: tr(StringsManager.createAccount),
            showArrow: false,
            fontWeight: FontWeight.w800,
            onPressed: isCheckedTerms
                ? () {
                    debugPrint(rEmailController?.text);
                    if (registerFormKey.currentState!.validate()) {
                      registerFunction(context);
                    }
                  }
                : null,
            color: ColorsManager.primaryDarkPurple,
          );
        } else {
          return const CustomCircleProgressIndicator();
        }
      },
    );
  }

  void registerFunction(BuildContext context) {
    var citiesCubit = context.read<GetCitiesCubit>();
    var selectedCountry = context.read<CityCubit>().state;
    var authBloc = context.read<AuthBloc>();
    var countryId = findAreaIdByName(citiesCubit.citiesData, selectedCountry!);
    print('country id is ${countryId}');
    UserData user = UserData(
        name: rFirstNameController!.text,
        email: rEmailController?.text,
        phone: rPhoneController!.text,
        avatar: "",
        bio: "",
        countryId: countryId);

    authBloc.add(Register(user: user, password: rPassController!.text));
  }
}
