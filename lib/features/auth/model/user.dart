// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? birthdate;
  final String? gender;
  final String password;
  final String? photoUrl;
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.birthdate,
    this.gender,
    required this.password,
    this.photoUrl,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? birthdate,
    String? gender,
    String? password,
    String? photoUrl,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
