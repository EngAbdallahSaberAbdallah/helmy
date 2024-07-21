import 'package:shared_preferences/shared_preferences.dart';

import '../constants/shared_prefs_constants.dart';

class SharedPreferencesHelper {
 

  static Future<String?> checkIfLogedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token =
        sharedPreferences.getString(SharedPreferencesConstants.tokenKey);
    return token;
  }

  static Future<void> setToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        SharedPreferencesConstants.tokenKey, token);
  }

  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences
        .getString(SharedPreferencesConstants.tokenKey)
        .toString();
    return token;
  }

  static Future<void> deleteUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(SharedPreferencesConstants.tokenKey);
  }

  static Future<void> setBoardingViewed(bool val) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(SharedPreferencesConstants.onBoarding, val);
  }

  static Future<bool> checkOnBoardingViewed() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool viewedOnBoarding =
        sharedPreferences.getBool(SharedPreferencesConstants.onBoarding) ??
            false;
    return viewedOnBoarding;
  }
}
