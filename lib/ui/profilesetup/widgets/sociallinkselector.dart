import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/browsing/definitions/chip_styles.dart';
import 'package:savethedate/ui/core/alertdialog_info.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_vm.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLinkSelector extends StatelessWidget {
  final ProfileSetupViewModel vm;

  SocialLinkSelector({super.key, required this.vm});

  @override
  final Map<String, IconData> platformIcons = {
    "Instagram": FontAwesomeIcons.instagram,
    "WhatsApp": FontAwesomeIcons.whatsapp,
    "Phone": FontAwesomeIcons.phone,
    "Other": FontAwesomeIcons.user,
  };
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Socials",
              style: GoogleFonts.inter(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                color: Color.fromARGB(255, 140, 140, 140),
                size: 20,
              ),
              onPressed: () {
                showAppDialog(
                  context: context,
                  title: "Privacy Info",
                  message:
                      "Your social handle won't be visible unless you're matched, "
                      "or you choose to show it directly on your profile.",
                  icon: Icons.info_outline,
                  iconColor: Colors.black,
                  buttonText: "Got it",
                );
              },
            ),
          ],
        ),

        // const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 12,
            children:
                ["Instagram", "WhatsApp", "Phone", "Other"]
                    .map(
                      (platform) => AppChipStyles.choiceHobby(
                        label: platform,
                        selected: vm.selectedSocialType == platform,
                        onSelected: (selected) {
                          if (selected) {
                            vm.selectedSocialType = platform;
                            vm.setSelectedSocialType(platform);
                          }
                        },
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
