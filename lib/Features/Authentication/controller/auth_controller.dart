import 'package:flutter/material.dart';
import 'package:sawago/Core/Helper/ToastHelper.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart'
    as AppUser;
import 'package:sawago/Repo/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> signup(AppUser.User user, BuildContext context) async {
    try {
      final newUser = await _authRepository.signup(user);
      if (newUser != null) {
        ToastHelper.showSuccess("تم إنشاء الحساب بنجاح ");
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> login(AppUser.User user, BuildContext context) async {
    try {
      final loggedInUser = await _authRepository.login(user);
      if (loggedInUser != null) {
        ToastHelper.showSuccess("تم تسجيل الدخول ");
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _authRepository.resetPassword(email);
      ToastHelper.showInfo(
          "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني ");
    } catch (e) {
      _showError(e.toString());
    }
  }


Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final user = await _authRepository.signInWithGoogle();
      if (user == null) {
        ToastHelper.showInfo("تم إلغاء تسجيل الدخول بحساب جوجل");
        return;
      }
      ToastHelper.showSuccess("تم تسجيل الدخول بحساب جوجل ");
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      _showError(e.toString());
    }
  }

 
  void _showError(String message) {
    ToastHelper.showError(message);
  }
}
