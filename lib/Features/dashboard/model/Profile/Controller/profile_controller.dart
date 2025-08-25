import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Features/Authentication/model/User_Model.dart';
import 'package:sawago/Repo/profile_repository.dart';

class ProfileCubit extends Cubit<UserModel> {
  final ProfileRepository _repository;


  bool fieldsEditable = false;

  ProfileCubit(this._repository)
      : super(UserModel(email: '', password: ''));

  Future<void> loadUser(String uid) async {
    try {
      final user = await _repository.getUserData(uid);
      if (user != null) emit(user);
    } catch (e) {
      print("Error loading user: $e");
    }
  }

  Future<void> updateUser() async {
    try {
      await _repository.updateUserData(state);
      fieldsEditable = false; 
      emit(state.copyWith()); 
    } catch (e) {
      print("Error updating user: $e");
    }
  }
  

  void toggleEditableFields() {
    fieldsEditable = !fieldsEditable;
    emit(state.copyWith()); 
  }

  
  void updateFirstName(String value) =>
      emit(state.copyWith(firstName: value));

  void updateLastName(String value) =>
      emit(state.copyWith(lastName: value));

  void updateEmail(String value) =>
      emit(state.copyWith(email: value));

  void updatePhone(String value) =>
      emit(state.copyWith(phone: value));

  void updateBio(String value) =>
      emit(state.copyWith(bio: value));

  void updateDateOfBirth(String value) =>
      emit(state.copyWith(dateOfBirth: value));

  void updatePhotoUrl(String value) =>
      emit(state.copyWith(photoUrl: value));
}
