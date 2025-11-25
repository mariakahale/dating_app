import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/ui/browsing/definitions/profiledef_v.dart';

class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? fb_feedback;

  /// Returns the current Firebase user's email (lowercased + trimmed)
  String? getUserEmail() {
    return getCurrentUser_ifExists()?.email;
  }

  getProfiles() {
    final profileList = <Profile>[];

    _db.collection("profiles").get().then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        profileList.add(
          Profile(
            age:
                data.toString().contains('age')
                    ? (data['age'] != null
                        ? int.tryParse(data['age'].toString()) ?? 0
                        : 0)
                    : 0,
            avatarType:
                data.toString().contains('avatarType')
                    ? data['avatarType'] ?? 'emoji'
                    : 'emoji',
            bio: data.toString().contains('bio') ? data['bio'] ?? '' : '',
            discipline:
                data.toString().contains('discipline')
                    ? data['discipline'] ?? ''
                    : '',
            gender:
                data.toString().contains('gender') ? data['gender'] ?? '' : '',
            hobbies:
                data.toString().contains('hobbies') && data['hobbies'] != null
                    ? List<String>.from(data['hobbies'])
                    : <String>[],
            imageUrl:
                data.toString().contains('imagePath')
                    ? data['imagePath'] ?? ''
                    : '',
            invitePrompt:
                data.toString().contains('invitePrompt')
                    ? data['invitePrompt'] ?? ''
                    : '',
            isUtorVerified:
                data.toString().contains('isUtorVerified')
                    ? data['isUtorVerified'] ?? false
                    : false,
            name: data.toString().contains('name') ? data['name'] ?? '' : '',
            showAge:
                data.toString().contains('showAge')
                    ? data['showAge'] ?? false
                    : false,
            showDiscipline:
                data.toString().contains('showDiscipline')
                    ? data['showDiscipline'] ?? false
                    : false,
            showGender:
                data.toString().contains('showGender')
                    ? data['showGender'] ?? false
                    : false,
            showHobbies:
                data.toString().contains('showHobbies')
                    ? data['showHobbies'] ?? false
                    : false,
            showInvitePrompt:
                data.toString().contains('showInvitePrompt')
                    ? data['showInvitePrompt'] ?? false
                    : false,
            showSocialLink:
                data.toString().contains('showSocialLink')
                    ? data['showSocialLink'] ?? false
                    : false,
            showYear:
                data.toString().contains('showYear')
                    ? data['showYear'] ?? false
                    : false,
            socialLink:
                data.toString().contains('socialLink')
                    ? data['socialLink'] ?? ''
                    : '',
            socialType:
                data.toString().contains('socialType')
                    ? data['socialType'] ?? ''
                    : '',
            year:
                data.toString().contains('year')
                    ? (data['year'] != null
                        ? int.tryParse(data['year'].toString()) ?? 0
                        : 0)
                    : 0,
          ),
        );
      }
      print("Profiles loaded: ${profileList.length}");
    }, onError: (e) => print("Error completing: $e"));
  }

  Future<String?> getImageURLfromFirebase() async {
    final user = getCurrentUser_ifExists();
    if (user == null) return null;

    try {
      final query =
          await _db
              .collection('profiles')
              .where("email", isEqualTo: normalizeEmail(user.email))
              .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        final data = doc.data();
        print(data['imagePath'] as String?);
        return data['imagePath'] as String?;
      }
    } catch (e) {
      print("Error reading image path from Firebase: $e");
    }

    return null;
  }

  Future<void> uploadImageURLtoFirebase(String imageUrl) async {
    final user = getCurrentUser_ifExists();
    if (user == null) return;

    try {
      final query =
          await _db
              .collection('profiles')
              .where("email", isEqualTo: normalizeEmail(user.email))
              .get();

      if (query.docs.isNotEmpty) {
        final docRef = query.docs.first.reference;
        await docRef.update({'imagePath': imageUrl});
      }
    } catch (e) {
      print("Error saving image URL to Firebase: $e");
    }
  }

  String? normalizeEmail(String? email) {
    if (email == null) {
      return null;
    }
    return email.trim().toLowerCase();
  }

  User? getCurrentUser_ifExists() {
    if (_auth.currentUser?.uid == null) {
      print("authorization failed");
      return null;
      // not logged
    } else {
      return _auth.currentUser; // logged
    }
  }

  Future<void> createProfileDoc({
    required String email,
    required String discipline,
    required Function(String) onError,
  }) async {
    if (getCurrentUser_ifExists() == null) {
      return null;
    }
    ;

    try {
      await _db.collection('profiles').add({
        'email': normalizeEmail(email),
        'discipline': discipline,
        'isUtorVerified': false,
      });
    } on FirebaseAuthException catch (e) {
      fb_feedback = e.message;
      onError(fb_feedback ?? "Registration failed, fb profile error");
      print('FB FEEDBACK $fb_feedback');
    }
  }

  // Get current user data
  Future<Query<Map<String, dynamic>>?> loadUserData() async {
    if (getCurrentUser_ifExists() == null) {
      return null;
    }
    ;

    try {
      final doc = await _db
          .collection('profiles')
          .where(
            "email",
            isEqualTo: normalizeEmail(getCurrentUser_ifExists()?.email),
          );
      return doc;
    } catch (e) {
      debugPrint("Error loading user data: $e");
      return null;
    }
  }

  Future<void> updateAvatarType({
    required String avatarType,
    required Function(String) onError,
  }) async {
    if (getCurrentUser_ifExists() == null) {
      return null;
    }
    ;

    try {
      final querySnapshot =
          await _db
              .collection('profiles')
              .where(
                "email",
                isEqualTo: normalizeEmail(getCurrentUser_ifExists()?.email),
              )
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;
        // print("${avatarType.name} $emoji $emojiBackgroundColor $imageUrl");
        await docRef.update({
          'avatarType': avatarType, // 'emoji' or 'image'
        });
      }
    } on FirebaseAuthException catch (e) {
      fb_feedback = e.message;
      onError(fb_feedback ?? "Failed to update avatar");
      print('FB FEEDBACK $fb_feedback');
    }
  }

  Future<void> updateProfileDoc({
    required String name,
    String? age,
    required bool showAge,
    String? year,
    required bool showYear,
    String? discipline,
    required bool showDiscipline,
    String? gender,
    required bool showGender,

    String? bio,

    String? socialLink,
    required bool showSocialLink,
    String? socialType,

    required bool showHobbies,
    List<String>? hobbies,

    String? invitePrompt,
    required bool showInvitePrompt,

    required Function(String) onError,
    required Function onSuccess,
  }) async {
    if (getCurrentUser_ifExists() == null) {
      return null;
    }
    ;

    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('profiles')
              .where(
                "email",
                isEqualTo: normalizeEmail(getCurrentUser_ifExists()?.email),
              )
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;

        await docRef.update({
          'name': name,
          'age': age,
          'showAge': showAge,
          'year': year,
          'showYear': showYear,
          'showDiscipline': showDiscipline,
          'discipline': discipline,
          'gender': gender,
          'showGender': showGender,
          'socialLink': socialLink,
          'showSocialLink': showSocialLink,
          'socialType': socialType,
          'invitePrompt': invitePrompt,
          'showInvitePrompt': showInvitePrompt,
          'showHobbies': showHobbies,
          'hobbies': hobbies,
          'bio': bio,
        });
        onSuccess("Profile updated successfully");
      } else {
        print(
          'No matching profile found for email: ${getCurrentUser_ifExists()?.email}',
        );
      }
    } on FirebaseAuthException catch (e) {
      fb_feedback = e.message;
      onError(fb_feedback ?? "Update profile failed, fb profile error");
      print('FB FEEDBACK $fb_feedback');
    }
  }

  // VERIFICATION STUFF
  Future<void> verifyOTPFirebase({
    required String uoftemail,
    required String entered_otp,
    required Function(String) onError,
    required Function() onSuccess,
  }) async {
    try {
      final query =
          await _db
              .collection('otp-verifications')
              .where("uoftEmail", isEqualTo: normalizeEmail(uoftemail))
              .orderBy("expiresAt", descending: true)
              .limit(1)
              .get();

      if (query.docs.isEmpty) {
        onError('No OTP found for this email.');
        return;
      }

      final data = query.docs.first.data();
      final storedOtp = data['otp'] as String?;
      final expiresAt = data['expiresAt'] as int?;

      if (storedOtp == null || expiresAt == null) {
        onError('OTP data is invalid.');
        return;
      }

      if (DateTime.now().millisecondsSinceEpoch > expiresAt) {
        onError('OTP has expired.');
        return;
      }

      if (entered_otp != storedOtp) {
        onError('Incorrect OTP.');
        return;
      }

      // OTP is valid
      onSuccess();
    } catch (e) {
      onError('Failed to verify OTP');
      print('Error verifying OTP: $e');
    }
  }

  Future<void> saveOtpVerification({
    required String uoftemail,
    required String otp,
    required int expiresAt,
    required Function(String) onError,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('otp-verifications').add({
        'uoftEmail': normalizeEmail(uoftemail),
        'email': getUserEmail(),
        'otp': otp,
        'expiresAt': expiresAt,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('send to otp-verification worked');
    } catch (e) {
      onError('Failed to save OTP verification: $e');
    }
  }

  Future<void> deleteOtpVerification({
    required String uoftemail,
    required Function(String) onError,
  }) async {
    try {
      final query =
          await _db
              .collection('otp-verifications')
              .where("uoftEmail", isEqualTo: normalizeEmail(uoftemail))
              .get();

      for (var doc in query.docs) {
        await doc.reference.delete();
      }
      print('OTP verification deleted successfully');
    } catch (e) {
      onError('Failed to delete OTP verification: $e');
    }
  }

  updateUofTVerified({required Null Function(dynamic msg) onError}) async {
    final user = getCurrentUser_ifExists();
    if (user == null) return;

    try {
      final query =
          await _db
              .collection('profiles')
              .where("email", isEqualTo: normalizeEmail(user.email))
              .get();

      if (query.docs.isNotEmpty) {
        final docRef = query.docs.first.reference;
        await docRef.update({'isUtorVerified': true});
      }
    } catch (e) {
      print("Error updating UofT verification: $e");
    }
  }

  Future<void> deleteProfileDoc({
    required String email,
    required void Function(dynamic msg) onError,
  }) async {
    try {
      if (email != '') {
        final normalizedEmail = email.trim().toLowerCase();
        final profileDocs =
            await _db
                .collection('profiles')
                .where('email', isEqualTo: normalizedEmail)
                .get();

        for (var doc in profileDocs.docs) {
          await doc.reference.delete();
        }
      } else {
        final user = getCurrentUser_ifExists();
        if (user == null) return;

        final query =
            await _db
                .collection('profiles')
                .where('email', isEqualTo: normalizeEmail(user.email))
                .get();

        if (query.docs.isNotEmpty) {
          await query.docs.first.reference.delete();
        }
      }
    } catch (e) {
      print("Error deleting profile document: $e");
      onError(e); // call the error callback
    }
  }
}
  



  // etc.

