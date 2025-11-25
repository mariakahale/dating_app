import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/login/login_v.dart';
import 'package:savethedate/ui/signin/login/chatgptlogin.dart';

class SignupMain extends StatelessWidget {
  const SignupMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save the date"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Image.asset('assets/canva_logo_slim.png'),
            const SizedBox(height: 200),
            CustombuttonWgt(
              text: "Login",
              color: myRed,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SigninScreen()),
                );
              },
              textcolor: Colors.white,
            ),
            const SizedBox(height: 30),
            CustombuttonWgt(
              text: "Sign up",
              color: Colors.grey,
              onPressed: nothing,
              textcolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

void sendtoLoginScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => SignupMain()));
}
