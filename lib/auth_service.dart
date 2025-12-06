import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // LOGIN GOOGLE UNTUK WEB
        final googleProvider = GoogleAuthProvider();
        final userCredential =
            await _auth.signInWithPopup(googleProvider);
        return userCredential;
      } else {
        // LOGIN GOOGLE UNTUK ANDROID/IOS
        final GoogleSignInAccount? googleUser =
            await _googleSignIn.signIn();
        if (googleUser == null) return null;

        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential;
      }
    } catch (e) {
      print('signInWithGoogle error: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (!kIsWeb) {
      await _googleSignIn.signOut();
    }
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
