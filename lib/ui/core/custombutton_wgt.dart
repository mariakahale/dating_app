import 'package:flutter/material.dart';
import 'package:pressable_flutter/pressable_flutter.dart';

class CustombuttonWgt extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final Color textcolor;

  const CustombuttonWgt({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.textcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Pressable(
      // effect: PressEffect.withSaturatedRipple(shrinkFactor: 0.8),
      duration: Duration(milliseconds: 40),
      onPress: onPressed,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
          // border: Border.all(color: greyColors.),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // shadows: List.filled(
              //   3,
              //   Shadow(
              //     color: Colors.black,
              //     offset: Offset(0.5, 0.5),
              //     blurRadius: 5,
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
