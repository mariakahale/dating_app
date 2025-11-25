import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/ui/myprofile/account_settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_v.dart';
import 'package:savethedate/ui/profilesetup/widgets/emojipicker.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "Not logged in";
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: ListView(
          children: [
            Text(
              "My Profile",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
            ),
            Text(
              "Hello, $email",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            SizedBox(height: 50),
            Text(
              "Settings",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),

              leading: const Icon(Icons.view_list),
              title: const Text(
                'Update profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => const ProfileSetupPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Account',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => const AccountSettingsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sms_failed_outlined),
              title: const Text(
                'Emoji picker',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //       builder: (_) => const EmojiAvatarPickerPage(),
              //     ),
              //   );
              // },
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder:
                      (context) => EmojiAvatarPickerSheet(
                        currentEmoji: '🎓',
                        currentColor: Colors.pink[100]!,
                        onAvatarSelected: (emoji, color) {
                          // Save to Firestore or state
                        },
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
