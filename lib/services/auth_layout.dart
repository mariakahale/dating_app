import 'package:flutter/material.dart';
import 'package:savethedate/services/auth_services.dart';
import 'package:savethedate/ui/core/apploadingpage.dart';
import 'package:savethedate/ui/navigation/homenavigation_v.dart';
import 'package:savethedate/ui/landing/landing_v.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key, this.pageIfNotConnected});
  final Widget? pageIfNotConnected;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService,

      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.waiting) {
              widget = const Apploadingpage();
            } else if (snapshot.hasData) {
              if (snapshot.data!.isAnonymous) {
                // Not a real signed-in user, show landing or login
                widget = pageIfNotConnected ?? const LandingScreen();
              } else {
                // User is signed in with a real account
                widget = HomeNavigationPage();
              }
            } else {
              widget = pageIfNotConnected ?? const LandingScreen();
            }
            return widget;
          },
        );
      },
    );
  }
}
