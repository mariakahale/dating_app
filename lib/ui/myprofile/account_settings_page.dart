import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/services/auth_services.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/myprofile/changepassword_chatgpt.dart';
import 'package:savethedate/ui/myprofile/delete_account_page.dart';
import 'package:savethedate/ui/signin/signup/entercode_v.dart';
// adjust to your path

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  void _handleUpdateEmail(BuildContext context) {
    // TODO: Navigate to update email screen or open dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("this feature is still under construction!"),
      ),
    );
  }

  void _handleVerifyOTP(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your UofT email'),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'example@mail.utoronto.ca',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final email = emailController.text.trim();
                if (email.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your email')),
                  );
                  return;
                }
                Navigator.of(context).pop(); // close dialog
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      return VerifyOTPCodeScreen(
                        uoftemail: email,
                      ); // pass email
                    },
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );
  }

  void _handleChangePassword(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (BuildContext context) {
          return CreateNewPasswordScreen();
        },
      ),
    );
  }

  void _handleDeleteAccount(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (BuildContext context) {
          return DeleteAccountPage();
        },
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    try {
      await authService.value.signOut();
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: const Color(0xFFFDF7F8),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: ListView(
          children: [
            SizedBox(height: 50),
            const Text(
              "Profile",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            ),

            const Text(
              "Account",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              leading: const Icon(Icons.email),
              title: const Text(
                'Update email',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => _handleUpdateEmail(context),
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              leading: const Icon(Icons.lock),
              title: const Text(
                'Change password',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => _handleChangePassword(context),
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              leading: const Icon(Icons.privacy_tip),
              title: const Text(
                'Verify UofT email',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                _handleVerifyOTP(context);
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              leading: const Icon(Icons.delete_forever, color: myRed),
              title: const Text(
                'Delete my account',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              textColor: myRed,
              onTap: () => _handleDeleteAccount(context),
            ),
            const Divider(),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () => _handleLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
