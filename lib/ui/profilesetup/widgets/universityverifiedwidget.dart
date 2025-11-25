import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget universityEmailStatus({
  required bool isVerified,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    // child: GestureDetector(
    // onTap: () {
    //   // show info dialog
    //   showDialog(
    //     context:
    //         navigatorKey
    //             .currentContext!, // make sure you have a global navigatorKey
    //     builder: (context) {
    //       return AlertDialog(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(16),
    //         ),
    //         title: const Text("UofT Verification"),
    //         content: const Text(
    //           "This badge means the user was able to verify access to a University of Toronto email address. "
    //           "It does not guarantee absolute identity security — always be safe when sharing personal information.",
    //         ),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Navigator.of(context).pop(),
    //             child: const Text("Got it"),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // },
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isVerified ? Icons.check_circle : Icons.cancel,
                  size: 24,
                  color: isVerified ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 10),
                Text(
                  isVerified ? "UofT verified" : "UofT not verified",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (_) => AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text("How hobbies work"),
                            content: const Text(
                              "This badge means the user was able to verify access to a University of Toronto email address. "
                              "\n\nIt does not guarantee absolute identity security — always be safe when sharing personal information.",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Got it"),
                              ),
                            ],
                          ),
                    );
                  },
                  child: const Icon(
                    Icons.info_outline,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),

                // const SizedBox(width: 6),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
