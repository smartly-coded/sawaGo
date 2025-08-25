import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      throw Exception("Failed to fetch user data: $e");
    }
  }

  Future<void> updateUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(
            user.toJson(),
            SetOptions(merge: true),
          );
    } catch (e) {
      throw Exception("Failed to update user data: $e");
    }
  }
}
