import 'dart:io';

class RegisterEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final File? profileImage;

  RegisterEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.profileImage,
  });
}
