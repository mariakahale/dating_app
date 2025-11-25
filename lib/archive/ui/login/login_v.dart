import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/buttonUnderlinedtext_wgt.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save the date"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hey,",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CupertinoTextField(
                cursorColor: myRed,
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              CupertinoTextField(
                cursorColor: myRed,
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
              SizedBox(height: 50),
              CustombuttonWgt(text: "Login", color: myRed, onPressed: nothing),
              SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomRight,
                child: UnderlinedButton_wgt(
                  text: "Forgot password",
                  onPressed: nothing,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
