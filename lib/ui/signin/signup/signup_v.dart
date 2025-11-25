import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/ui/signin/login/chatgptlogin.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/signin/signup/entercode_v.dart';
import 'package:savethedate/ui/signin/signup/signup_vm.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),

      child: const SignupForm(),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

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
    final vm = Provider.of<SignupViewModel>(context);
    final fb = Provider.of<FirestoreService>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: const Color(0xFFFDF7F8),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: Form(
              key: vm.formKey,
              child: Column(
                children: [
                  // const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome!",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Let's set your account up",
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
                    controller: vm.emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration('Email Address'),
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Enter a valid personal email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // University Email
                  TextFormField(
                    controller: vm.universityEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration(
                      'University Email (@mail.utoronto.ca)',
                    ),
                    validator: (value) {
                      if (value == null || !value.endsWith('utoronto.ca')) {
                        return 'Must be a valid UofT email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Discipline Dropdown
                  DropdownButtonFormField<String>(
                    decoration: inputDecoration('Discipline'),
                    items:
                        disciplines_list.map((discipline) {
                          return DropdownMenuItem(
                            value: discipline,
                            child: Text(discipline),
                          );
                        }).toList(),
                    onChanged: (value) => vm.selectedDiscipline = value,
                    validator:
                        (value) => value == null ? 'Select a discipline' : null,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    controller: vm.passwordController,
                    obscureText: true,
                    decoration: inputDecoration('Password'),
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  // if (vm.feedback != null) ...[
                  //   Text(
                  //     vm.feedback!,
                  //     style: const TextStyle(color: Colors.red),
                  //   ),
                  //   const SizedBox(height: 12),
                  // ],
                  CustombuttonWgt(
                    text: "Sign me up!",
                    color: myRed,
                    textcolor: Colors.white,

                    onPressed: () async {
                      if (vm.formKey.currentState!.validate()) {
                        vm.registerAuth(
                          onSuccess: () async {
                            fb.createProfileDoc(
                              email: vm.emailController.text,
                              discipline: vm.selectedDiscipline ?? "undeclared",
                              onError: (msg) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(msg)));
                              },
                            );

                            await ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  "Account created successfully",
                                ),
                                width: 250,
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                            vm.sendOtpVerification(context);

                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder:
                                    (_) => VerifyOTPCodeScreen(
                                      uoftemail:
                                          vm.universityEmailController.text,
                                    ),
                              ),
                            );
                          },
                          onError: (msg) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${vm.feedback}"),
                                width: 200,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(builder: (_) => SigninScreen()),
                          );
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myRed,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
