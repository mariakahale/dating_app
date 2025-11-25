import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/underlinedtext_wgt.dart';
import 'package:savethedate/ui/navigation/homenavigation_v.dart';
import 'package:savethedate/ui/signin/login/chatgptlogin.dart';
import 'package:savethedate/ui/signin/signup/signup_v.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:video_player/video_player.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // const _LandingScreenState({super.key});
  late VideoPlayerController _controller;
  @override
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/groovy-enhanced.mp4')
      ..initialize().then((_) {
        _controller.setVolume(0);
        _controller.setLooping(false); // optional: loop forever
        _controller.play(); // ✅ start playing AFTER init
        setState(() {}); // trigger UI rebuild
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              Text(
                "Crushing on more than just your homework?",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  // fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              _controller.value.isInitialized
                  ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                  : Text("didn't work"),
              CustombuttonWgt(
                textcolor: Colors.white,
                text: "Sign up",
                color: myRed,
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return SignupScreen();
                      },
                    ),
                  );
                },
              ),
              CustombuttonWgt(
                textcolor: myRed,
                text: "Log in",
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (BuildContext context) {
                        return SigninScreen();
                      },
                    ),
                  );
                },
              ),

              // CustombuttonWgt(
              //   textcolor: Colors.white,
              //   text: "Profiles page",
              //   color: myRed,
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       CupertinoPageRoute(
              //         builder: (BuildContext context) {
              //           return HomeNavigationPage();
              //         },
              //       ),
              //     );
              //   },
              // ),
              // Text("^this takes you to profiles"),
              const SizedBox(height: 40),

              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  children: [
                    UnderlinedtextWgt(
                      text: "Profiles page",
                      onTapped: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (BuildContext context) {
                              return HomeNavigationPage();
                            },
                          ),
                        );
                      },
                      // onTapped: () => sendtoLoginScreen,
                    ),
                    // UnderlinedtextWgt(
                    //   text: "login",
                    //   onTapped: () {
                    //     Navigator.of(context).push(
                    //       CupertinoPageRoute(
                    //         builder: (BuildContext context) {
                    //           return const SigninScreen();
                    //         },
                    //       ),
                    //     );
                    //   },
                    //   // onTapped: () => sendtoLoginScreen,
                    // ),
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
