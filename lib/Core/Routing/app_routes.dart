import 'package:flutter/material.dart';
import 'package:sawago/Features/Authentication/ForgetPassword/veiw/ForgetPass_screen.dart';
import 'package:sawago/Features/Authentication/login/veiw/login_screen.dart';
import 'package:sawago/Features/Authentication/onBoarding/veiw/onboarding_Screens.dart';
import 'package:sawago/Features/Authentication/sign%20up/veiw/sign_up_screen.dart';
import 'package:sawago/Features/dashboard/model/home/veiw/HomePage.dart';

class AppRoutes {
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forgetPassword';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      onboarding: (context) => const OnboardingScreen(),
      login: (context) => const LoginView(),
      signup: (context) => const SignupView(),
      home: (context) => const Homepage(),
      forgetPassword: (context) => const ForgetPasswordView(),
    };
  }
}
