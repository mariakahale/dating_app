import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:savethedate/ui/browsing/definitions/chip_styles.dart';
import 'package:savethedate/ui/browsing/definitions/profiledef_v.dart';
import 'package:savethedate/ui/browsing/definitions/typographybrowsing.dart';
import 'package:savethedate/ui/browsing/viewmodels/profiledetail_vm.dart';
import 'package:savethedate/ui/core/custombutton_wgt.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/profilesetup/widgets/universityverifiedwidget.dart';
import 'definitions/likebuttondef_v.dart';
import 'package:savethedate/ui/browsing/viewmodels/likemanager_vm.dart';

class ProfileDetailPage extends StatelessWidget {
  final Profile profile;

  const ProfileDetailPage({super.key, required this.profile});

  Widget renderProfilePic() {
    return Image.memory(
      profile.imageBytes!,
      width: 120,
      height: 120,
      fit: BoxFit.cover,

      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.broken_image, size: 32, color: Colors.white);
      },
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileDetailViewModel(profile: profile),
      builder: (context, _) {
        final viewModel = Provider.of<ProfileDetailViewModel>(context);
        return SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Hero(
                tag: 'card-${profile.name}',
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  color: viewModel.backgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildHeader(profile, context),
                          const SizedBox(height: 16),
                          ..._buildDynamicSections(viewModel, context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Profile profile, BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: renderProfilePic(),
        ),

        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Centered name
                  Text(
                    '${profile.name}${(profile.showAge == true) ? ', ${profile.age}' : ''}',
                    style: BrowsingTextStyles.profileName,
                    textAlign: TextAlign.center,
                  ),

                  // Right-aligned like button
                  Positioned(
                    right: 0,
                    child: LikeButton(
                      isLiked: Provider.of<LikeManager>(
                        context,
                        listen: false,
                      ).isLiked(1, ""),
                      onToggle: () {
                        Provider.of<LikeManager>(
                          context,
                          listen: false,
                        ).toggleLike(1, "");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Liked ${profile.name}',
                              textAlign: TextAlign.center,
                            ),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 160,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 8),
            universityEmailStatus(
              isVerified: profile.isUtorVerified,
              context: context,
            ),
          ],
        ),

        // Card(
        //   color: Colors.white,
        //   child: Container(
        //     width: double.infinity,
        //     padding: const EdgeInsets.all(12),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         Text("👤", style: TextStyle(fontSize: 20)),
        //         const SizedBox(width: 15),
        //         Expanded(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text("Opening line :)", style: BrowsingTextStyles.body),
        //               Text(
        //                 profile.intro,
        //                 style: const TextStyle(fontSize: 20),
        //                 textAlign: TextAlign.left,
        //                 softWrap: true,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  _buildHobbySection(Profile p) {
    if (p.hobbies != null && p.hobbies!.isNotEmpty && p.showHobbies)
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hobbies", style: BrowsingTextStyles.h1),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8,
                children:
                    p.hobbies!
                        .map((hobby) => AppChipStyles.hobby(hobby))
                        .toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    return const SizedBox.shrink(); // return empty widget instead of null
  }

  String getEmojiforYear(int? year) {
    String emoji;
    switch (year) {
      case 1:
        emoji = "🌱"; // First year
        break;
      case 2:
        emoji = "🌿"; // Second year
        break;
      case 3:
        emoji = "🌳"; // Third year
        break;
      case 4:
        emoji = "🎓"; // Fourth year
        break;
      default:
        emoji = "📚"; // Generic for other years
    }
    return emoji;
  }

  _buildQuickInfoSection(Profile p) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Info", style: BrowsingTextStyles.h1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              children: [
                if (p.showDiscipline) AppChipStyles.hobby("🎓 ${p.discipline}"),
                SizedBox(width: 8),
                if (p.showYear && (toOrdinal(p.year)) != "-1" && p.year != null)
                  AppChipStyles.hobby(
                    "${getEmojiforYear(p.year)} ${toOrdinal(p.year)} year",
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // inside your profile detail page:
  Widget _buildInvitePromptSection(Profile p, BuildContext context) {
    if (p.invitePrompt != null)
      return Card(
        color: Colors.white,
        // elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: double.infinity,

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '📩 Invite Prompt',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  p.invitePrompt!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),

                CustombuttonWgt(
                  text: "Send invite",
                  color: myRed,
                  textcolor: Colors.white,
                  onPressed: () {
                    // logic to respond to invite
                  },
                ),

                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.black,
                //     foregroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //   ),
                //   onPressed: () {
                //     // logic to respond to invite
                //   },
                //   icon: const Icon(Icons.send),
                //   label: const Text("Send Invite"),
                // ),
              ],
            ),
          ),
        ),
      );

    return const SizedBox.shrink();
  }

  Widget _buildSocialsLink(Profile p) {
    if (p.showSocialLink && p.socialLink != null && p.socialLink!.isNotEmpty) {
      IconData platformIcon;
      switch (p.socialType) {
        case "Instagram":
          platformIcon =
              Icons.camera_alt_outlined; // replace with FontAwesome if you want
          break;
        case "WhatsApp":
          platformIcon = Icons.chat_bubble_outline;
          break;
        case "Phone":
          platformIcon = Icons.phone;
          break;
        default:
          platformIcon = Icons.alternate_email;
      }

      return Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(platformIcon, color: Colors.black, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  p.socialLink!,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  List<Widget> _buildDynamicSections(
    ProfileDetailViewModel viewModel,
    context,
  ) {
    final p = viewModel.profile;
    return [
      _buildQuickInfoSection(p),
      SizedBox(height: 10),
      _buildHobbySection(p),
      _buildInvitePromptSection(p, context),
      _buildSocialsLink(p),
      ...[const SizedBox(height: 16)],

      // if (p.socialLink != null) ...[
      //   Container(
      //     width: double.infinity,
      //     // Make the bio card expand full width
      //     child: Card(
      //       color: Colors.white,
      //       elevation: 0,

      //       child: Padding(
      //         padding: EdgeInsets.all(12),
      //         child: Column(
      //           crossAxisAlignment:
      //               CrossAxisAlignment.start, // align text to start
      //           children: [
      //             Text("Socials", style: BrowsingTextStyles.body),
      //             Text(
      //               "${p.socialLink!}",
      //               style: const TextStyle(fontSize: 20),
      //               textAlign: TextAlign.left,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),

      //   ),
      //   const SizedBox(height: 16),
      // ],

      // if (p.secondaryImageUrl != null) ...[
      //   ClipRRect(
      //     borderRadius: BorderRadius.circular(16),
      //     child: Image.network(
      //       p.secondaryImageUrl!,
      //       height: 150,
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //   const SizedBox(height: 16),
      // ],
    ];
  }

  String toOrdinal(int? number) {
    if (number == null) return "-1";
    if (number < 0) return "-1";

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }
}
