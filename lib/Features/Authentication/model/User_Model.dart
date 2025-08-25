class UserModel {
  final String? uid; 
  final String? firstName;
  final String? lastName;
  final String email;
  final String password;
  final String? dateOfBirth;
  final String? phone;
  final String? bio;
  final String? photoUrl;
  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    this.dateOfBirth,
    this.phone,
    this.bio,
    this.photoUrl,
  });

 
  Map<String, dynamic> toJson() => {
        'uid': uid ?? '',
        'firstName': firstName ?? '',
        'lastName': lastName ?? '',
        'email': email,
        'password': password,
        'dateOfBirth': dateOfBirth ?? '',
        'phone': phone ?? '',
        'bio': bio ?? '',
        'photoUrl': photoUrl ?? '',
      };

  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      dateOfBirth: json['dateOfBirth'],
      phone: json['phone'],
      bio: json['bio'],
      photoUrl: json['photoUrl'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? dateOfBirth,
    String? phone,
    String? bio,
    String? photoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
