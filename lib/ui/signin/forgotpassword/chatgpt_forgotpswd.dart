import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/services/auth_services.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final bool _isLoading = false;
  String? _errormessage;

  Future<void> showSnackBar() async {
    await ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please check your email', textAlign: TextAlign.center),

        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        width: 250,
      ),
    );
  }

  void _resetPassword() async {
    try {
      // await authService.value.sendPasswordResetEmail(
      //   email: _emailController.text,
      // );
      authService.value.sendPasswordResetEmail(
        email: _emailController.text,
        context: context,
      );
      // showSnackBar();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errormessage = e.message ?? 'this is not working';
      });
    }
    // if (!_formKey.currentState!.validate()) return;

    // setState(() {
    //   _isLoading = true;
    //   _feedbackMessage = null;
    // });

    // try {
    //   setState(() {
    //     _feedbackMessage = 'A password reset email has been sent.';
    //   });
    // } on FirebaseAuthException catch (e) {
    //   setState(() {
    //     _feedbackMessage = e.message ?? 'Failed to send reset email.';
    //   });
    // } catch (e) {
    //   setState(() {
    //     _feedbackMessage = 'Something went wrong. Please try again.';
    //   });
    // } finally {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: myRed, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: const Color(0xFFFDF7F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "Forgot password?",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your email to receive a reset link.",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 36),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration('Email Address'),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                if (_errormessage != null) ...[
                  Text(
                    _errormessage!,
                    style: TextStyle(
                      color:
                          _errormessage!.startsWith('A password reset')
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Reset Button
                Align(
                  alignment: Alignment.center,
                  child: CustombuttonWgt(
                    text: _isLoading ? "Sending..." : "Reset password",
                    color: myRed,
                    textcolor: Colors.white,
                    onPressed: () {
                      _isLoading
                          ? null
                          : {
                            if (_formKey.currentState!.validate())
                              {_resetPassword()},
                          };
                    },
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
