import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawago/Core/Utils/Validation.dart';
import 'package:sawago/Features/dashboard/model/Profile/model/profile_model.dart';


class ProfileCubit extends Cubit<ProfileModel> {
  ProfileCubit() : super(ProfileModel());

  void toggleEdit(String field) {
    final newEditable = Map<String, bool>.from(state.editableFields);
    newEditable[field] = !(newEditable[field] ?? false);
    emit(state.copyWith(editableFields: newEditable));
  }

  void updateFirstName(String value) =>
      emit(state.copyWith(firstName: value));

  void updateLastName(String value) =>
      emit(state.copyWith(lastName: value));

  void updateBirthDate(String value) =>
      emit(state.copyWith(birthDate: value));

  void updateEmail(String value) {
    if (Validators.validateEmail(value) != null) {
      emit(state.copyWith(email: value));
    }
  }

  void updatePhone(String value) {
    if (Validators.isValidPhone(value)) {
      emit(state.copyWith(phone: value));
    }
  }

  void updateBio(String value) =>
      emit(state.copyWith(bio: value));
}