import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/core/alertdialog_info.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_v.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_vm.dart';

class InvitePromptCarousel extends StatelessWidget {
  final String? selectedPrompt;
  final ValueChanged<String> onSelected;
  final ProfileSetupViewModel vm;

  InvitePromptCarousel({
    super.key,
    required this.selectedPrompt,
    required this.vm,
    required this.onSelected,
  });
  final customInvitePrompt_Controller = TextEditingController();

  void _showCustomPromptSheet(BuildContext context) {
    customInvitePrompt_Controller.text = selectedPrompt ?? '';

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Write your own invite prompt",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  maxLength: 50,
                  controller: customInvitePrompt_Controller,
                  decoration: inputDecoration("Type your prompt here..."),
                ), // const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final text = customInvitePrompt_Controller.text;
                    if (text.isNotEmpty) {
                      onSelected(text); // ✅ send the actual custom prompt
                      vm.setCustomInvitePrompt(text);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prompts = [
      "Grab coffee together ☕",
      "Brunch this weekend 🥞",
      "Take a walk by the lake 🌊",
      "Try a new dessert 🍰",
      "Play some arcade games 🎮",
      "Grab bubble tea 🧋",
      "Go to a campus event ⚽",
      "custom",
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Expanded(
                flex: 5,

                child: Row(
                  children: [
                    Text(
                      textAlign: TextAlign.start,
                      "Invite Prompt",
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        showAppDialog(
                          context: context,
                          title: "What is an Invite Prompt?",
                          message:
                              "An invite prompt is a short, fun suggestion you can send "
                              "to someone to start a conversation or invite them to "
                              "an activity. \n\nYou can also write your own (just selected 'custom')!",
                          icon: Icons.info_outline,
                          iconColor: Colors.black,
                          buttonText: "Got it",
                        );
                      },
                      child: Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: vm.showInvitePrompt,
                  onChanged: (val) => vm.setShowInvitePrompt(val ?? false),
                  shape: const CircleBorder(),
                  visualDensity: VisualDensity.compact,
                  activeColor: myRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.75),
              itemCount: prompts.length,
              itemBuilder: (context, index) {
                final prompt = prompts[index];
                // var isSelected = prompt == selectedPrompt;

                final isCustomCard = prompt == "custom";
                final isSelected =
                    isCustomCard
                        ? selectedPrompt ==
                            vm
                                .invitePromptController
                                .text // ✅ compare actual text
                        : prompt == selectedPrompt;

                if (prompt == "custom") {
                  // render the custom prompt card
                  return GestureDetector(
                    onTap: () => _showCustomPromptSheet(context),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.only(left: 16, right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color.fromARGB(255, 255, 241, 243)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color:
                              isSelected
                                  ? myRed // softer pink-red
                                  // keep pale pink
                                  : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, color: myRed, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              vm.invitePromptController.text.isNotEmpty
                                  ? vm.invitePromptController.text
                                  : "Write your own",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: myRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      if (prompt == selectedPrompt) {
                        onSelected(
                          '',
                        ); // or null, depending on your parent handling
                      } else {
                        onSelected(prompt);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? const Color.fromARGB(255, 255, 241, 243)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color:
                              isSelected
                                  ? myRed // softer pink-red
                                  // keep pale pink
                                  : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          prompt,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? myRed : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
