import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/browsing/definitions/likebuttondef_v.dart';
import 'package:savethedate/ui/profilesetup/widgets/avatarchoiceselector.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileCard extends StatelessWidget {
  final String avatarType;
  final String? imageUrl;

  final String name;

  final int age;
  final bool showAge;

  final String discipline;
  final bool showDiscipline;

  final String intro;

  final bool isLiked;
  final void Function() onToggle;

  final double imgHeight;
  final EdgeInsets edgePaddingInsets;
  final int eventId;

  const ProfileCard({
    super.key,
    required this.avatarType,
    this.imageUrl,

    required this.name,

    required this.age,
    required this.showAge,

    required this.intro,
    required this.imgHeight,
    required this.edgePaddingInsets,
    required this.isLiked,
    required this.eventId,
    required this.onToggle,
    required this.discipline,
    required this.showDiscipline,
    // required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgePaddingInsets,
      child: Hero(
        tag: 'card-$name',
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 120, // Adjust this height
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Optional: match card radius
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: imageUrl ?? 'https://i.pravatar.cc/300?img=15',
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 4),
                child: Column(
                  children: [
                    Text(
                      showAge ? '$name, $age' : name,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (showDiscipline)
                      Text(
                        discipline,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(intro),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LikeButton(isLiked: isLiked, onToggle: () => ()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
