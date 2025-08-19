import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:sawago/Features/Authentication/model/User_Model.dart' as AppUser;

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

  String _handleFirebaseAuthError(fb.FirebaseAuthException e) {
    switch (e.code) {
      case "email-already-in-use":
        return "هذا البريد مستخدم بالفعل";
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
