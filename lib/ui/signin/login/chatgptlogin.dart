import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/services/auth_services.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/core/underlinedtext_wgt.dart';
import 'package:savethedate/ui/navigation/homenavigation_v.dart';
import 'package:savethedate/ui/signin/forgotpassword/chatgpt_forgotpswd.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  void signIn() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    _error = null;

    final error = await authService.value.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (error != null) {
      // Display error in SnackBar and update UI
      setState(() => _error = error);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 320,
        ),
      );
    } else {
      // Success, navigate to Home
      if (mounted) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (_) => HomeNavigationPage()),
        );
      }
    }

    if (mounted) setState(() => _isLoading = false);
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
              children: [
                const SizedBox(height: 100),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome back!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 36),
                    ],
                  ),
                ),

                // Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: inputDecoration('Email Address'),
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: inputDecoration('Password'),
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: UnderlinedtextWgt(
                    text: "Forgot password?",
                    onTapped: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (BuildContext context) {
                            return ForgotPasswordScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // if (_error != null) ...[
                //   Text(_error!, style: const TextStyle(color: Colors.red)),
                //   const SizedBox(height: 12),
                // ],

                // Sign In Button
                CustombuttonWgt(
                  text: _isLoading ? "Signing in..." : "Log in",
                  color: myRed,
                  textcolor: Colors.white,
                  onPressed: () {
                    _isLoading
                        ? null
                        : {
                          if (_formKey.currentState!.validate()) {signIn()},
                        };
                  },
                ),
                const SizedBox(height: 20),

                // Redirect to Sign Up
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Don’t have an account?"),
                //     TextButton(
                //       onPressed: () {
                //         // TODO: Navigate to SignUp
                //         Navigator.of(
                //           context,
                //         ).pop(); // if navigated from SignUp
                //       },
                //       child: const Text(
                //         "Sign Up",
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           color: Color(0xFFBF5A76),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
