import 'package:flutter/material.dart';
import 'package:savethedate/ui/signup_main/signup_main_v.dart';

class UnderlinedtextWgt extends StatelessWidget {
  final String text;
  final VoidCallback onTapped;

  const UnderlinedtextWgt({
    required this.text,
    required this.onTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => sendtoLoginScreen,
      child: Text(
        text,
        // textAlign: textAlign,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
