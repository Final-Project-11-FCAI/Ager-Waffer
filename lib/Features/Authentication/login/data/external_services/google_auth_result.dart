import 'package:firebase_auth/firebase_auth.dart';

class GoogleAuthResult {
  final User user;
  final String accessToken;

  GoogleAuthResult({
    required this.user,
    required this.accessToken,
  });
}