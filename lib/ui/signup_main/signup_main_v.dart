import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';

class SignupMain extends StatelessWidget {
  const SignupMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Image.asset('assets/canva_logo_slim.png'),
              const SizedBox(height: 100),
              CustombuttonWgt(text: "Login", color: myRed),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
