

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Core/Helper/ToastHelper.dart';
import 'package:sawago/Repo/auth_repository.dart';
import 'package:sawago/Services/shared_pref.dart';
import 'auth_state.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart'
    as AppUser;

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(AppUser.UserModel user) async {
    emit(AuthLoading());
    try {
      final loggedInUser = await _authRepository.login(user);
      if (loggedInUser != null) {
        await SharedPrefService.saveUid(loggedInUser.uid);
        
        print("User UID: ${loggedInUser.uid}");
        emit(AuthSuccess(loggedInUser.uid));
      } else {
        emit(AuthFailure("Login failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signup(AppUser.UserModel user) async {
    emit(AuthLoading());
    try {
      final newUser = await _authRepository.signup(user);
      if (newUser != null) {
        await SharedPrefService.saveUid(newUser.uid);
         await FirebaseFirestore.instance.collection('users').doc(newUser.uid).set(user.toJson());
        emit(AuthSuccess(newUser.uid));
      } else {
        emit(AuthFailure("Signup failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
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
Future<void> signInWithGoogle() async {
  emit(AuthLoading());
  try {
    final user = await _authRepository.signInWithGoogle();
    if (user != null) {

      await SharedPrefService.saveUid(user.uid);

     
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
          "uid": currentUser.uid,
          "name": currentUser.displayName,
          "email": currentUser.email,
          "photoUrl": currentUser.photoURL,
          "createdAt": FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      emit(AuthSuccess(user.uid));
    } else {
      emit(AuthFailure("Google Sign-In cancelled"));
    }
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}
Future<void> signInWithFacebook() async {
  emit(AuthLoading());
  try {
    final user = await _authRepository.signInWithFacebook();
    if (user != null) {

      await SharedPrefService.saveUid(user.uid);

     
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
          "uid": currentUser.uid,
          "name": currentUser.displayName,
          "email": currentUser.email,
          "photoUrl": currentUser.photoURL,
          "createdAt": FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }

      emit(AuthSuccess(user.uid));
    } else {
      emit(AuthFailure("Facebook Sign-In cancelled"));
    }
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}

  void logout() async {
    await SharedPrefService.clearUid();
    emit(AuthInitial());
  }

  void _showError(String message) {
    ToastHelper.showError(message);
  }
}
