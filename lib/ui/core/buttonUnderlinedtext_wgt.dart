import 'package:flutter/material.dart';
import 'package:pressable_flutter/pressable_flutter.dart';

class UnderlinedButton_wgt extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const UnderlinedButton_wgt({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Pressable(
      // effect: PressEffect.withSaturatedRipple(shrinkFactor: 0.8),
      duration: Duration(milliseconds: 40),
      onPress: onPressed,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.underline,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
