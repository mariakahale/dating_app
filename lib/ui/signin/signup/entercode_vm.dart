import 'package:flutter/material.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/ui/navigation/homenavigation_v.dart';

class EntercodeVm extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  Future<void> verifyOTP(
    BuildContext context,
    String uoftemail,
    String entered_otp,
  ) async {
    await FirestoreService().verifyOTPFirebase(
      entered_otp: entered_otp,
      uoftemail: uoftemail,
      onError: (msg) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg, textAlign: TextAlign.center),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 320,
          ),
        );

        if (msg == 'OTP has expired.') {
          await FirestoreService().deleteProfileDoc(
            email: '',
            onError: (msg) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            },
          );
        }
      },
      onSuccess:
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeNavigationPage()),
          ),
    );
  }

  Future<void> deleteOTP(BuildContext context, String uoftemail) async {
    await FirestoreService().deleteOtpVerification(
      uoftemail: uoftemail,
      onError: (msg) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      },
    );
  }

  Future<void> update_uoftVerified(BuildContext context) async {
    await FirestoreService().updateUofTVerified(
      onError: (msg) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      },
    );
  }
}
