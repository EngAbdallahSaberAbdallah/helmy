import '../modules/auth/models/auth_response.dart';

import '../resources/values_manager.dart';

class Constants {
  static AuthResponse authResponse = AuthResponse();
  static const int splashDelay = 2;

  static List<double> fonts = [
    AppSize.s18,
    AppSize.s16,
    AppSize.s14,
    AppSize.s12,
    AppSize.s10,
  ];

  static Map<String, dynamic> lawyerUpdatePersonalDataRequest({
    required String firstName,
    required String lastName,
    required String gender,
    required int areaId,
    required String? phone,
    required String? imgPath,
    String? email,
    String? address,
  }) {
    final request = (imgPath != "")
        ? {
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "area": areaId,
            "phone": phone,
            "avatar": imgPath,
            if (email!.isNotEmpty) "email": email,
            if (address!.isNotEmpty) "address": address
          }
        : {
            "first_name": firstName,
            "last_name": lastName,
            "gender": gender,
            "area": areaId,
            "phone": phone,
            if (email!.isNotEmpty) "email": email,
            if (address!.isNotEmpty) "address": address
          };

    return request;
  }

  static String whatsAppNumber = '+002-(010)4740040';
}
