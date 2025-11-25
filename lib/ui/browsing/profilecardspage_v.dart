import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:savethedate/ui/browsing/profilecard_v.dart';
import 'package:savethedate/ui/browsing/profiledetailpage_v.dart';
import 'package:savethedate/ui/browsing/viewmodels/profileslist_vm.dart';
import 'package:savethedate/ui/browsing/viewmodels/likemanager_vm.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileListViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Discover'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        body: Consumer<ProfileListViewModel>(
          builder: (context, viewModel, _) {
            final profiles = viewModel.profiles;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MasonryGridView.count(
                itemCount: profiles.length,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder:
                              (_, __, ___) => Scaffold(
                                appBar: AppBar(),
                                body: ProfileDetailPage(profile: profile),
                              ),
                        ),
                      );
                    },
                    child: ProfileCard(
                      showAge: profile.showAge,
                      showDiscipline: profile.showDiscipline,
                      avatarType: profile.avatarType,
                      name: profile.name,
                      age: profile.age,
                      imageUrl: profile.imageUrl,
                      intro: profile.bio,
                      discipline: profile.discipline,
                      imgHeight: 120,
                      edgePaddingInsets: EdgeInsets.zero,
                      isLiked: Provider.of<LikeManager>(
                        context,
                        listen: false,
                      ).isLiked(1, ""),
                      eventId: 1,
                      onToggle: () {
                        Provider.of<LikeManager>(
                          context,
                          listen: false,
                        ).toggleLike(1, "");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Liked ${profile.name}'),
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 160,
                          ),
                        );
                      },
                      // onLike: () {
                      //   viewModel.likeProfile(profile);
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //         'Liked ${profile.name}',
                      //         textAlign: TextAlign.center,
                      //       ),
                      //       duration: Duration(seconds: 2),
                      //       behavior: SnackBarBehavior.floating,
                      //       width: 140,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //     ),
                      //   );
                      // },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
