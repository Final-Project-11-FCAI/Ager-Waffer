import 'package:ager_waffer/Features/Authentication/login/data/external_services/google_auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthExternalService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<GoogleAuthResult?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: "784984253888-9guiv8svk035agkdqpibn97nrk7kbe4u.apps.googleusercontent.com",
      );

      final GoogleSignInAccount googleUser =
      await _googleSignIn.authenticate();

      final authorization = await googleUser.authorizationClient
          .authorizationForScopes([
        'email',
        'profile',
        'openid',
      ]);

      if (authorization == null) return null;

      final accessToken = authorization.accessToken;

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) return null;

      return GoogleAuthResult(
        user: user,
        accessToken: accessToken,
      );
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }


  Future<String?> signInWithFacebookAndGetAccessToken() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        print("❌ Facebook login failed: ${result.message}");
        return null;
      }

      final accessToken = result.accessToken?.tokenString;

      if (accessToken == null) {
        print("❌ AccessToken is null");
        return null;
      }

      // 🔥 Firebase login
      final OAuthCredential credential =
      FacebookAuthProvider.credential(accessToken);

      await _auth.signInWithCredential(credential);

      print("✅ Firebase login success");

      return accessToken;
    } catch (e) {
      print("🔥 Facebook Error: $e");
      return null;
    }
  }

}