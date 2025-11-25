import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/core/globals.dart';

void main() => runApp(ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profiles',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFDF6F9), // soft pink
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: ProfileList(),
    );
  }
}

class Profile {
  final String name;
  final int age;
  final String imageUrl;
  final String intro;

  Profile({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.intro,
  });
}

class ProfileList extends StatelessWidget {
  final List<Profile> profileList = [
    Profile(
      name: 'Emma',
      age: 22,
      imageUrl: 'https://i.pravatar.cc/150?img=1',
      intro: '📚 bookworm & coffee lover',
    ),
    Profile(
      name: 'Lily',
      age: 20,
      imageUrl: 'https://i.pravatar.cc/150?img=2',
      intro: '🎨 painting my way through life',
    ),
    Profile(
      name: 'Maya',
      age: 23,
      imageUrl: 'https://i.pravatar.cc/150?img=3',
      intro: '✨ sunsets & sushi dates',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: MasonryGridView.count(
          itemCount: profileList.length,
          crossAxisCount: 2, // 2 cards per row
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          // childAspectRatio: 0.65,
          itemBuilder: (context, index) {
            final profile = profileList[index];
            return ProfileCard(
              name: profile.name,
              age: profile.age,
              imageUrl: profile.imageUrl,
              intro: profile.intro,
              onLike: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Liked ${profile.name}'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                      bottom: 80, // pushes it above bottom nav if needed
                      left: 16,
                      right: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final int age;
  final String imageUrl;
  final String intro;
  final VoidCallback onLike;

  const ProfileCard({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.intro,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 3,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '$name, $age',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  intro,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 30), // Spacer to make room for button
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: GestureDetector(
            onTap: onLike,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: myRed,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
