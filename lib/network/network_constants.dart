class NetworkConstants {
  static String token = '';
  static bool isInterpreter = false;
  static String lang = '';
  static const int apiTimeOut = 60 * 1000;
  static bool? onboarding;

  static const String productionBaseUrl = 'https://www.helmyeg.com/api/';
  static const String testingBaseUrl = "https://stage.helmyeg.com/api/";

  static const String baseUrl = productionBaseUrl;

  static const String testImageUrl = "";

  // End points
  static const String login = 'login';
  static const String register = 'register';
  static const String googleLogin = 'login/google/callback';
  static const String verifyOTPEmailVerification =
      "verify-email/verify-user-email";
  static const String resentOTP = "verify-email/resend-code";
  static const String forgetPassword = 'forgot-password/email';

  static const String codeCheck = "password/code/check";
  static const String verifyEmailWithCode = "verify-email/verify-user-email";
  static const String changePassword = 'changePassword';
  static const String resetPassword = 'password/reset';
  static const String cities = 'countries';

  static const String dream = '${NetworkConstants.baseUrl}dreams';
  static const String showDream =
      '${NetworkConstants.baseUrl}show-dream/'; // no. of dream
  static const String addDream = '${NetworkConstants.baseUrl}add-dream';
  static const String addDreamComment =
      '${NetworkConstants.baseUrl}add-dream-comment';
  static const String interpreterDreams =
      '${NetworkConstants.baseUrl}interpreter-dreams';

  static const String favourite =
      '${NetworkConstants.baseUrl}favorites'; // get, add, delete
  static const String plans = '${NetworkConstants.baseUrl}plans';
  static const String countries = '${NetworkConstants.baseUrl}countries';
  static const String interpreter = '${NetworkConstants.baseUrl}interpreters';
  static const String settings = '${NetworkConstants.baseUrl}settings';

  static const String updateProfile =
      '${NetworkConstants.baseUrl}update-profile';
  static const String userProfile = '${NetworkConstants.baseUrl}user-profile';

  static const String updatePassword =
      '${NetworkConstants.baseUrl}update-password';
  static const String deleteUser = '${NetworkConstants.baseUrl}delete-user';
}
