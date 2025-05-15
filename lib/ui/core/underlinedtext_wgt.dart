import 'dart:developer';

import 'package:flutter/material.dart';

class UnderlinedtextWgt extends StatelessWidget {
  final String text;
  const UnderlinedtextWgt({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => log('onPress'),
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
