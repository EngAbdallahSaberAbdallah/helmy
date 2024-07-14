import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../modules/interpreter/start/views/interpreter_start_view.dart';
import '../modules/start/views/drawer_view.dart';
import '../modules/start/views/start_view.dart';
import '../helpers/animations_helper.dart';
import '../modules/auth/views/forget_password_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/views/reset_password_done_view.dart';
import '../modules/onboarding/views/onboarding_view.dart';

class HelmyRoutes {
  static const String onboardingRoute = 'onboardingView';
  static const String loginRoute = 'loginView';
  static const String registerRoute = 'registerView';
  static const String forgetPasswordRoute = 'changePasswordView';
  static const String resetPasswordDoneRoute = 'resetPasswordDoneView';
  static const String userStartRoute = 'userStartView';
  static const String interpreterStartRoute = 'interpreterStartView';
  static const String consultationOffersRoute = 'consultationOffersView';
  static const String allLawyersRoute = 'allLawyersView';
  static const String lawyerProfile = "lawyerProfile";
  static const String addNewConsultationFormRoute =
      'addNewConsultationFormView';
  static const String userInvitationsDetailsViewRoute =
      'userInvitationsDetailsViewView';
  static const String drawerRoute = 'DrawerView';
  static const String requestConsultation = 'requestConsultation';
  static const String orderDetail = "orderDetail";
  static const String thankYouPage = "thankYouPage";
  static const String allOrders = "allOrders";
  static const String userProfileData = "userProfileData";
  static const String editUserProfileData = "editUserProfileData";
  static const String notificationsRoute = "notificationsRoute";
}

class HelmyRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HelmyRoutes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case HelmyRoutes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case HelmyRoutes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case HelmyRoutes.forgetPasswordRoute:
        final fromChangePassword = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => ForgetPasswordView(
                  fromChangePassword: fromChangePassword,
                ));
      case HelmyRoutes.resetPasswordDoneRoute:
        var isRestFromRoot = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => ResetPasswordDoneView(
                  isRestFromRoot: isRestFromRoot,
                ));
      case HelmyRoutes.userStartRoute:
        return MaterialPageRoute(builder: (_) => const StartView());
      case HelmyRoutes.interpreterStartRoute:
        return MaterialPageRoute(builder: (_) => const InterpreterStartView());
      case HelmyRoutes.drawerRoute:
        return SlideTransitionAnimation(
            child: const DrawerView(), direction: AxisDirection.left);
      // case HelmyRoutes.userProfileData:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //           create: (_) => ProfileCubit(ProfileRepository()),
      //           child: const UserFullProfile()));
      // case HelmyRoutes.editUserProfileData:
      //   final userMap = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => UserProfileData(
      //           authResponse: userMap['authResponse'],
      //           isFromUpdateLawyerData: userMap['isFromUpdateUserData']));
      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    setSystemUiOverlayStyle();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    setSystemUiOverlayStyle();
  }

  void setSystemUiOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }
}
