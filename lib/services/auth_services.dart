import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Returns the current user (if signed in)
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of user authentication changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  String? snackbarMessage;

  Future<String?> createAccount({
    required String email,
    required String password,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && currentUser.isAnonymous) {
        final credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await currentUser.linkWithCredential(credential);
        return null; // success
      } else {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return null; // success
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return 'An account with that email already exists.';
      } else if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else {
        debugPrint('FirebaseAuthException: ${e.message}');
        return e.message ?? 'Unknown Firebase Auth error.';
      }
    } catch (e) {
      debugPrint('Unknown error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Sign in with email and password
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No account found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect password.';
      } else {
        debugPrint('FirebaseAuthException: ${e.message}');
        return e.message ?? 'Unknown Firebase Auth error.';
      }
    } catch (e) {
      debugPrint('Unknown error: $e');
      return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> sendPasswordResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    // Simple email format validation
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please enter a valid email address.',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 320,
        ),
      );
      return;
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please check your email',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 250,
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Failed to send password reset email.'),
        ),
      );
    }
  }

  /// Update username (display name)

  Future<void> updateUsername({required String newName}) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'You must be logged in to change your email.',
      );
    } else {
      await currentUser!.updateDisplayName(newName);
      await currentUser!.reload();
    } // Refresh the user info
  }

  /// Delete the currently signed-in user's account
  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'No user is currently signed in.',
      );
    }

    try {
      // Re-authenticate
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);

      // Delete account
      await user.delete();
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint('🔥 DeleteAccount Error: ${e.code} - ${e.message}');
      if (e.code == 'invalid-credential') {
        // Most likely password is incorrect or session expired
        throw FirebaseAuthException(
          code: 'reauthentication-failed',
          message:
              'Reauthentication failed. Please check your password or log in again.',
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> sendUtoremail({
    required String utorEmail,
    required ActionCodeSettings acs,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.sendEmailVerification();
    }
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-logged-in',
        message: 'You must be logged in to change your password.',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  Future<void> signInAnonymously() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInAnonymously();
      print("Signed in anonymously with UID: ${userCredential.user?.uid}");
    } catch (e) {
      print("Error signing in anonymously: $e");
    }
  }
}
