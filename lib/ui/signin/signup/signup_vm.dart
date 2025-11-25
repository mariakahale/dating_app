import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:savethedate/services/auth_services.dart';
import 'package:savethedate/services/firestore_service.dart';
// import 'package:sendgrid_mailer/sendgrid_mailer.dart';

class SignupViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final universityEmailController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedDiscipline;
  String? feedback;
  Future<void> sendOtpVerification(BuildContext context) async {
    final otpData = generateOtpAndExpiry();
    await FirestoreService().saveOtpVerification(
      uoftemail: universityEmailController.text,
      otp: otpData['otp'],
      expiresAt: otpData['expiresAt'],
      onError: (msg) {
        feedback = msg;
        notifyListeners();
      },
    );
    // sendSendgridEmail(context, otpData['otp']);
  }

  /// Generates a 6-digit OTP and expiry timestamp (5 minutes from now)
  Map<String, dynamic> generateOtpAndExpiry() {
    final otp =
        (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
    final expiresAt =
        DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch;
    return {'otp': otp, 'expiresAt': expiresAt};
  }

  /// Sends a verification email using SendGrid
  // Future<void> sendSendgridEmail(BuildContext context, String otp) async {
  //   final apiKey = dotenv.env['SENDGRID_API_KEY'];
  //   if (apiKey == null) {
  //     feedback = "SendGrid API key not found.";
  //     notifyListeners();
  //     return;
  //   }

  //   final mailer = Mailer(apiKey);
  //   final toAddress = Address(universityEmailController.text.trim());
  //   final fromAddress = Address('savethedate.v1@gmail.com');
  //   final subject = 'Your UofT Verification Code';
  //   final content = Content('text/plain', 'Your verification code is: $otp');

  //   final personalization = Personalization([toAddress]);
  //   final email = Email(
  //     [personalization],
  //     fromAddress,
  //     subject,
  //     content: [content],
  //   );

  //   try {
  //     final result = await mailer.send(email);

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Verification email sent to ${universityEmailController.text}.',
  //           textAlign: TextAlign.center,
  //         ),
  //         behavior: SnackBarBehavior.floating,

  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         width: 320,
  //       ),
  //     );
  //     debugPrint('Email sent: $result');
  //   } catch (e) {
  //     feedback = "Failed to send verification email.";
  //     notifyListeners();
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('Failed to send email: $e')));
  //     debugPrint('Error sending email: $e');
  //   }
  // }

  /// Registers a new user with Firebase Auth
  Future<String?> registerAuth({
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    final error = await authService.value.createAccount(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    if (error != null) {
      feedback = error;
      notifyListeners();
      onError(error);
      return error;
    }

    onSuccess();
    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    universityEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> deleteallinfo(BuildContext context) async {
    FirestoreService().deleteProfileDoc(
      email: emailController.text,
      onError: (msg) {
        feedback = msg;
        notifyListeners();
      },
    );
    FirestoreService().deleteOtpVerification(
      uoftemail: universityEmailController.text,
      onError: (msg) {
        feedback = msg;
        notifyListeners();
      },
    );
  }
}
