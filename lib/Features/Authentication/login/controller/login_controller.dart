// import 'package:flutter/material.dart';
// import 'package:sawago/Features/Authentication/login/model/User_Model.dart';

// class AuthController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // تسجيل الدخول
//   Future<User?> login(User user, BuildContext context) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//         email: user.email,
//         password: user.password,
//       );
//       return result.user;
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? 'حدث خطأ أثناء تسجيل الدخول')),
//       );
//       return null;
//     }
//   }

//   // إنشاء حساب
//   Future<User?> signup(User user, BuildContext context) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//         email: user.email,
//         password: user.password,
//       );
//       return result.user;
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(e.message ?? 'حدث خطأ أثناء إنشاء الحساب')),
//       );
//       return null;
//     }
//   }
// }