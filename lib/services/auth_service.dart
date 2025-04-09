import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Configure Google Sign In with proper scopes
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password, [String? name, String? phone]) async {
    // Create user with email and password
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update user profile if name is provided
    if (name != null && name.isNotEmpty) {
      await userCredential.user?.updateDisplayName(name);
    }

    return userCredential;
  }

  // Sign in with Google - handles both web and Android
  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential? userCredential;

      // For web platform
      if (kIsWeb) {
        // Create a GoogleAuthProvider with customized parameters
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        // Add scopes
        googleProvider.addScope('email');
        googleProvider.addScope('https://www.googleapis.com/auth/userinfo.profile');

        // Force account selection - this is key for showing the account picker
        googleProvider.setCustomParameters({
          'prompt': 'select_account'
        });

        // Sign in with popup will show account selector on web
        userCredential = await _auth.signInWithPopup(googleProvider);
      }
      // For Android/iOS
      else {
        // Trigger the authentication flow with account picker
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        // If user cancels the sign-in process
        if (googleUser == null) return null;

        // Obtain the auth details
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in with Firebase using the Google credential
        userCredential = await _auth.signInWithCredential(credential);
      }

      return userCredential;
    } catch (e) {
      print('Error during Google sign in: $e');
      rethrow;
    }
  }

  // Sign out (works for both platforms)
  Future<void> signOut() async {
    // Sign out from Google (for mobile)
    if (!kIsWeb) {
      await _googleSignIn.signOut();
    }
    // Sign out from Firebase (works for both)
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
