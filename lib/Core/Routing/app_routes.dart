import 'package:flutter/material.dart';
import 'package:sawago/Features/Authentication/ForgetPassword/veiw/ForgetPass_screen.dart';
import 'package:sawago/Features/Authentication/login/veiw/login_screen.dart';
import 'package:sawago/Features/Authentication/onBoarding/veiw/onboarding_Screens.dart';
import 'package:sawago/Features/Authentication/sign%20up/veiw/sign_up_screen.dart';
import 'package:sawago/Features/dashboard/model/Profile/view/profile_Screen.dart';
import 'package:sawago/Features/dashboard/model/Trips/view/TripsPage.dart';
import 'package:sawago/Features/dashboard/model/home/veiw/HomePage.dart';
import 'package:sawago/Features/dashboard/model/trip_tracking_location/veiw/map_tracking_page.dart';
import 'package:sawago/Features/dashboard/model/wallet/view/wallet_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRoutes {
  static const String home = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forgetPassword';
  static const String profile = '/profile';
  static const String trips = '/trips';
  static const String tracking_trip = '/tracking_trip';

  static Map<String, WidgetBuilder> getRoutes() {
    Future<String?> getUserId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userId');
    }

    return {
      onboarding: (context) => const OnboardingScreen(),
      login: (context) => const LoginView(),
      signup: (context) => const SignupView(),
      home: (context) => const Homepage(),
      forgetPassword: (context) => const ForgetPasswordView(),
      profile: (context) => const ProfileScreen(),
      trips: (context) => const TripsPage(),
     // tracking_trip: (context) => const MapTrackingPage(driverId: "unknown"),
     
    };
  }
}
