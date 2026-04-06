import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthExternalService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<String?> signInWithGoogleAndGetAccessToken() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: "784984253888-5k2hdf3ltoeg0f3uecr5g7l8n907oaid.apps.googleusercontent.com",
      );

      final GoogleSignInAccount user =
      await _googleSignIn.authenticate();

      print("Google user selected");

      // 2️⃣ الحصول على accessToken
      final authorization = await user.authorizationClient
          .authorizationForScopes([
        'email',
        'profile',
        'openid',
      ]);

      if (authorization == null) {
        print("Authorization failed");
        return null;
      }

      final accessToken = authorization.accessToken;
      print("AccessToken: $accessToken");

      final googleAuth = user.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      return accessToken;
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