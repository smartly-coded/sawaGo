import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart'
    as AppUser;

class AuthRepository {
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<fb.User?> signup(AppUser.UserModel user) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      final fb.User? fbUser = credential.user;

      if (fbUser != null) {
        await _createUserDoc(fbUser, extraData: {
          "name": "${user.firstName} ${user.lastName}",
          "phone": user.phone,
          "bio": user.bio,
          "dateOfBirth": user.dateOfBirth,

        });
      }

      return fbUser;
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    } catch (e) {
      throw Exception("حدث خطأ غير متوقع: $e");
    }
  }

  Future<fb.User?> login(AppUser.UserModel user) async {
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
        final fb.User? user = cred.user;

        if (user != null) {
          await _createUserDoc(user);
        }
        return user;
      } else {
        final gUser = await GoogleSignIn().signIn();
        if (gUser == null) return null;
        final gAuth = await gUser.authentication;
        final credential = fb.GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );
        final userCred = await _firebaseAuth.signInWithCredential(credential);
        final fb.User? user = userCred.user;

        if (user != null) {
          await _createUserDoc(user);
        }
        return user;
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
        final fb.User? user = cred.user;

        if (user != null) {
          await _createUserDoc(user);
        }
        return user;
      } else {
        final LoginResult result = await FacebookAuth.instance.login(
          permissions: ['email', 'public_profile'],
        );

        switch (result.status) {
          case LoginStatus.success:
            if (result.accessToken == null) {
              throw Exception("فشل في الحصول على رمز الوصول من فيسبوك");
            }

            final String tokenValue = result.accessToken!.tokenString;
            final credential = fb.FacebookAuthProvider.credential(tokenValue);
            final userCred =
                await _firebaseAuth.signInWithCredential(credential);
            final fb.User? user = userCred.user;

            if (user != null) {
              await _createUserDoc(user);
            }
            return user;

          case LoginStatus.cancelled:
            throw Exception("تم إلغاء تسجيل الدخول بفيسبوك");
          case LoginStatus.failed:
            throw Exception("فشل تسجيل الدخول بفيسبوك: ${result.message}");
          case LoginStatus.operationInProgress:
            throw Exception("عملية تسجيل الدخول قيد التنفيذ");
          default:
            throw Exception("حالة غير معروفة في تسجيل الدخول بفيسبوك");
        }
      }
    } on fb.FirebaseAuthException catch (e) {
      throw Exception(_handleFirebaseAuthError(e));
    } catch (e) {
      if (e.toString().contains("EUNSPECIFIED")) {
        throw Exception("خطأ في إعدادات فيسبوك. تأكد من تكوين التطبيق");
      } else if (e.toString().contains("network")) {
        throw Exception("خطأ في الاتصال. تأكد من اتصالك بالإنترنت");
      }
      throw Exception("خطأ في تسجيل الدخول بفيسبوك: $e");
    }
  }




 Future<void> _createUserDoc(fb.User user, {Map<String, dynamic>? extraData}) async {
  final userDoc = _firestore.collection("users").doc(user.uid);

  try {
    if (!(await userDoc.get()).exists) {
      await userDoc.set({
        "uid": user.uid,
        "email": user.email,
        "name": user.displayName ?? extraData?["name"] ?? "",
        "phone": user.phoneNumber ?? extraData?["phone"] ?? "",
        "photoUrl": user.photoURL ?? "",
        "createdAt": FieldValue.serverTimestamp(),
      });
    }
  } on FirebaseException catch (e) {
   
    throw Exception("Firestore Error: ${e.message}");
  } catch (e) {
    throw Exception("Unexpected Firestore error: $e");
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
