class ProfileModel {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String email;
  final String phone;
  final String bio;
  final Map<String, bool> editableFields;

  ProfileModel({
    this.firstName = "",
    this.lastName = "",
    this.birthDate = "",
    this.email = "",
    this.phone = "",
    this.bio = "",
    this.editableFields = const {},
  });

  ProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? birthDate,
    String? email,
    String? phone,
    String? bio,
    Map<String, bool>? editableFields,
  }) {
    return ProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      editableFields: editableFields ?? this.editableFields,
    );
  }
}