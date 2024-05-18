import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'languages_helper.dart';

const String prefsKeyLang = 'prefsKeyLang';
const String prefsKeyVerificationId = 'prefsKeyVerificationId';
const String prefsKeyPhone = 'prefsKeyPhone';
const String prefsKeyToken = 'prefsKeyToken';
const String prefsKeyIsInterpreter = 'prefsKeyIsInterpreter';
const String prefsKeyOnBoarding = 'onBoarding';
const String prefsKeyName = 'prefsKeyName';
const String prefsKeyLastName = 'prefsKeyLastName';
const String prefsKeyGender = 'prefsKeyGender';
const String prefsKeyEmail = 'prefsKeyEmail';
const String prefsKeyCity = 'prefsKeyCity';
const String prefsKeyArea = 'prefsKeyArea';
const String prefsKeyAreaId = 'prefsKeyAreaId';
const String prefsKeyAvatar = 'prefsKeyAvatar';
const String fontSizeKey = 'fontSize';
const String fontSizeForContainerKey = 'fontSizeForContainerKey';

class CacheHelper {
  final SharedPreferences _sharedPreferences;

  CacheHelper(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String language = _sharedPreferences.getString(prefsKeyLang) ??
        LanguageType.english.getValue();
    return language;
  }

  Future<void> changeAppLanguage() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      /// set it to english
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.english.getValue());
    } else {
      /// set it to arabic
      _sharedPreferences.setString(
          prefsKeyLang, LanguageType.arabic.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLang = await getAppLanguage();
    if (currentLang == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

   Future<void> setFontSize({required double fontSize}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(
        fontSizeKey, fontSize);
  }

   Future<double> getFontSize() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double fontSize = sharedPreferences
        .getDouble(fontSizeKey)!
        .toDouble();
    return fontSize;
  }

  
   Future<void> setFontSizeForContainer({required double containerWidth}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(
        fontSizeForContainerKey, containerWidth);
  }

   Future<double> getFontSizeForContainer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double containerWidth = sharedPreferences
        .getDouble(fontSizeForContainerKey)!
        .toDouble();
    return containerWidth;
  }


  Future<void> saveVerificationId(String verificationId) async {
    _sharedPreferences.setString(prefsKeyVerificationId, verificationId);
  }

  Future<String?> getVerificationId() async {
    String? verificationId =
        _sharedPreferences.getString(prefsKeyVerificationId);
    return verificationId;
  }

  Future<void> savePhone(String phone) async {
    _sharedPreferences.setString(prefsKeyPhone, phone);
  }

  Future<void> saveCity(String city) async {
    _sharedPreferences.setString(prefsKeyCity, city);
  }

  Future<String?> getCity() async {
    String? city = _sharedPreferences.getString(prefsKeyCity);
    return city;
  }

  Future<void> saveArea(String area) async {
    _sharedPreferences.setString(prefsKeyArea, area);
  }

  Future<String?> getArea() async {
    String? area = _sharedPreferences.getString(prefsKeyArea);
    return area;
  }

  Future<void> saveAreaId(int areaId) async {
    _sharedPreferences.setInt(prefsKeyAreaId, areaId);
  }

  Future<int?> getAreaId() async {
    int? areaId = _sharedPreferences.getInt(prefsKeyAreaId);
    return areaId;
  }

  Future<String?> getPhone() async {
    String? phone = _sharedPreferences.getString(prefsKeyPhone);
    return phone;
  }

  Future<void> saveName(String name) async {
    _sharedPreferences.setString(prefsKeyName, name);
  }

  Future<String?> getName() async {
    String? name = _sharedPreferences.getString(prefsKeyName);
    return name;
  }

  Future<void> saveLastName(String lastName) async {
    _sharedPreferences.setString(prefsKeyLastName, lastName);
  }

  Future<String?> getLastName() async {
    String? lastName = _sharedPreferences.getString(prefsKeyLastName);
    return lastName;
  }

  Future<void> saveAvatar(String avatar) async {
    _sharedPreferences.setString(prefsKeyAvatar, avatar);
  }

  Future<String?> getAvatar() async {
    String? avatar = _sharedPreferences.getString(prefsKeyAvatar);
    return avatar;
  }

  Future<void> saveGender(String gender) async {
    _sharedPreferences.setString(prefsKeyGender, gender);
  }

  Future<String?> getGender() async {
    String? gender = _sharedPreferences.getString(prefsKeyGender);
    return gender;
  }

  Future<void> saveEmail(String email) async {
    _sharedPreferences.setString(prefsKeyEmail, email);
  }

  Future<String?> getEmail() async {
    String? email = _sharedPreferences.getString(prefsKeyEmail);
    return email;
  }

  Future<void> saveToken(String token) async {
    _sharedPreferences.setString(prefsKeyToken, token);
  }

  Future<String?> getToken() async {
    String? token = _sharedPreferences.getString(prefsKeyToken);
    return token;
  }

  Future<void> saveIsInterpreter(bool isInterpreter) async {
    _sharedPreferences.setBool(prefsKeyIsInterpreter, isInterpreter);
  }

  Future<bool?> getIsInterpreter() async {
    bool? isInterpreter = _sharedPreferences.getBool(prefsKeyIsInterpreter);
    return isInterpreter;
  }

  removeToken() {
    _sharedPreferences.remove(prefsKeyToken);
  }

  
  removeIsInterpreter() {
    _sharedPreferences.remove(prefsKeyIsInterpreter);
  }

  Future<void> saveOnBoarding(bool isTrue) async {
    _sharedPreferences.setBool(prefsKeyOnBoarding, isTrue);
  }

  Future<bool?> getOnBoarding() async {
    bool? onboarding = _sharedPreferences.getBool(prefsKeyOnBoarding);
    return onboarding;
  }
}
