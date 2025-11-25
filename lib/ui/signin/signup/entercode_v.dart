import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/signin/signup/entercode_vm.dart';

class VerifyOTPCodeScreen extends StatefulWidget {
  final String uoftemail;
  const VerifyOTPCodeScreen({super.key, required this.uoftemail});

  @override
  State<VerifyOTPCodeScreen> createState() =>
      _VerifyOTPCodeScreenState(uoftemail: uoftemail);
}

class _VerifyOTPCodeScreenState extends State<VerifyOTPCodeScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  var uoftemail;

  _VerifyOTPCodeScreenState({required this.uoftemail});

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      counterText: '', // <-- Add this line

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
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entercode_vm = Provider.of<EntercodeVm>(context);

    // ...existing code before the Row...
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: const Color(0xFFFDF7F8),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                Text(
                  "Verify your UofT email.",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 16),
                    children: [
                      TextSpan(
                        text:
                            "We’ve sent a 6-digit code to ${widget.uoftemail}. ",
                      ),
                      TextSpan(
                        text: "\nCheck your JUNK/SPAM ",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text:
                            "if you don’t see it. \n\nWe don’t store your email — this is only for verification.",
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 40),

                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (i) {
                    return Padding(
                      padding: EdgeInsets.only(right: i < 6 - 1 ? 10 : 0),
                      child: SizedBox(
                        width: 45,
                        child: TextFormField(
                          controller: _controllers[i],
                          focusNode: _focusNodes[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: inputDecoration(''),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && i < 6 - 1) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_focusNodes[i + 1]);
                            } else if (value.isEmpty && i > 0) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_focusNodes[i - 1]);
                            }
                          },
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: CustombuttonWgt(
                    text: "Verify",
                    color: myRed,
                    textcolor: Colors.white,
                    // onPressed: () {
                    //   Navigator.of(context).push(
                    //     CupertinoPageRoute(
                    //       builder: (BuildContext context) {
                    //         return const ResetPswdScreen();
                    //       },
                    //     ),
                    //   );
                    // },
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await entercode_vm.verifyOTP(
                          context,
                          widget.uoftemail,
                          _controllers.map((c) => c.text).join(),
                        );
                        await entercode_vm.deleteOTP(context, widget.uoftemail);
                        await entercode_vm.update_uoftVerified(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
