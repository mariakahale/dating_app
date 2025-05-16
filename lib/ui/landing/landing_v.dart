import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/underlinedtext_wgt.dart';
import 'package:savethedate/ui/signup_main/signup_main_v.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:savethedate/ui/core/globals.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 180),
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/canva_logo_slim.png'),
              ),
              const SizedBox(height: 100),
              CustombuttonWgt(
                text: "Tutorial",
                color: myRed,
                onPressed: nothing,
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    UnderlinedtextWgt(
                      text: "Skip to login",
                      onTapped: () => sendtoLoginScreen,
                    ),
                    SizedBox(width: 150),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void sendtoLoginScreen(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => SignupMain()));
}
