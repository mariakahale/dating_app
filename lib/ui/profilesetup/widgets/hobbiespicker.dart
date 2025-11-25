import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:savethedate/ui/browsing/definitions/chip_styles.dart';
import 'package:savethedate/ui/core/alertdialog_info.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_v.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_vm.dart';

class HobbySelector extends StatelessWidget {
  const HobbySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfileSetupViewModel>(context);
    final suggestions =
        vm.currentInput.isEmpty ? allHobbies : vm.filteredSuggestions;

    final customInput = vm.currentInput.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title + info button
        Row(
          children: [
            Text(
              "Hobbies",
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 6),
            GestureDetector(
              onTap: () {
                showAppDialog(
                  context: context,
                  title: "How hobbies work",
                  message:
                      "Choose your 3 hobbies from the suggestions below.\n"
                      "Start typing to see hobby suggestions.\n\n"
                      "If your hobby isn’t listed, you can add it manually.\n"
                      "Don’t forget: check the ‘Show hobbies’ box to make them visible on your profile!",
                  icon: Icons.info_outline,
                  iconColor: Colors.black,
                  buttonText: "Got it",
                );
              },
              child: const Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: vm.hobbyInputController,
                decoration: inputDecoration(
                  "Type a hobby",
                  controller: vm.hobbyInputController,
                ),
                onChanged: vm.updateHobbyInput,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              // flex: 1,
              child: Row(
                children: [
                  // const Text("Show", style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Transform.scale(
                    scale: 1.2, // try 1.2 to 1.3
                    child: Checkbox(
                      value: vm.showHobbies,
                      onChanged: (val) => vm.setShowHobbies(val ?? false),
                      shape: const CircleBorder(),
                      visualDensity: VisualDensity.compact,
                      activeColor: myRed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        /// Suggestions row (scrollable)
        SizedBox(
          height: 40,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 6,

              children: [
                if (customInput.isNotEmpty &&
                    !allHobbies
                        .map((h) => h.toLowerCase())
                        .contains(customInput.toLowerCase()) &&
                    !vm.selectedHobbies
                        .map((h) => h.toLowerCase())
                        .contains(customInput.toLowerCase()))
                  GestureDetector(
                    onTap: () {
                      vm.addHobby(customInput);
                      vm.hobbyInputController.clear();
                      vm.updateHobbyInput("");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AppChipStyles.hobby('➕ Add "$customInput"'),
                      // Chip(
                      //   label: Text('➕ Add "$customInput"'),
                      //   backgroundColor: Colors.green[100],
                      // ),
                    ),
                  ),
                ...suggestions.map((hobby) {
                  return GestureDetector(
                    onTap: () {
                      vm.addHobby(hobby);
                      vm.hobbyInputController.clear();
                      vm.updateHobbyInput("");
                    },

                    // padding: const EdgeInsets.only(right: 8),
                    child: AppChipStyles.hobby(hobby),
                  );
                }),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// Selected hobbies row
        if (vm.selectedHobbies.isNotEmpty) ...[
          Text(
            "Your Hobbies:",
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 6,
              children:
                  vm.selectedHobbies
                      .map(
                        (hobby) => AppChipStyles.removeHobby(
                          hobby,
                          () => vm.removeHobby(hobby),
                        ),
                      )
                      .toList(),
            ),
          ),
          // SizedBox(
          //   height: 40,
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.horizontal,
          //     child: Row(
          //       children:
          //           vm.selectedHobbies.map((hobby) {
          //             return Padding(
          //               padding: const EdgeInsets.only(right: 8),
          //               child: InputChip(
          //                 label: Text(hobby),
          //                 selected: true,
          //                 onDeleted: () => vm.removeHobby(hobby),
          //                 backgroundColor: Colors.black87,
          //                 deleteIcon: const Icon(Icons.close, size: 18),
          //               ),
          //             );
          //           }).toList(),
          //     ),
          //   ),
          // ),
        ],
      ],
    );
  }
}
