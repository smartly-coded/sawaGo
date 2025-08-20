import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart'
    as AppUser;

class AuthRepository {
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;

  Future<fb.User?> signup(AppUser.User user) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return credential.user;
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: $e");
    }
  }

  Future<fb.User?> login(AppUser.User user) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return credential.user;
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: $e");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    }
  }

  Future<fb.User?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = fb.GoogleAuthProvider();
        final cred = await _firebaseAuth.signInWithPopup(provider);
        return cred.user;
      } else {
        final gUser = await GoogleSignIn().signIn();
        if (gUser == null) return null;
        final gAuth = await gUser.authentication;
        final credential = fb.GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        final userCred = await _firebaseAuth.signInWithCredential(credential);
        return userCred.user;
      }
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: $e");
    }
  }

  Future<fb.User?> signInWithFacebook() async {
    try {
      if (kIsWeb) {
        final provider = fb.FacebookAuthProvider();
        final cred = await _firebaseAuth.signInWithPopup(provider);
        return cred.user;
      } else {
        final LoginResult result = await FacebookAuth.instance.login(
          permissions: ['email', 'public_profile'],
        );

        if (result.status == LoginStatus.success) {
          print('Access Token: ${result.accessToken}');
          print('Token type: ${result.accessToken.runtimeType}');

          final tokenString = result.accessToken!.toString();
          final credential = fb.FacebookAuthProvider.credential(tokenString);

          final userCred = await _firebaseAuth.signInWithCredential(credential);
          return userCred.user;
        } else {
          return null;
        }
      }
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: $e");
    }
  }

  String _handleFirebaseAuthError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case "email-already-in-use":
        return "هذا البريد مستخدم بالفعل";
      case "account-exists-with-different-credential":
        return "الإيميل مسجل بطريقة مختلفة. جرّبي تسجيل الدخول بنفس الطريقة السابقة.";
      case "weak-password":
        return "كلمة المرور ضعيفة جداً";
      case "invalid-email":
        return "البريد الإلكتروني غير صالح";
      case "user-not-found":
        return "المستخدم غير موجود";
      case "wrong-password":
        return "كلمة المرور غير صحيحة";
      default:
        return "خطأ: ${e.message}";
    }
  }
}
