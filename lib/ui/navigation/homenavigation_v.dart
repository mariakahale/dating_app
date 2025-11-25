import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savethedate/services/supabase.dart';
import 'package:savethedate/ui/browsing/likescardspage_v.dart';
import 'package:savethedate/ui/browsing/profilecardspage_v.dart';
import 'package:savethedate/ui/myprofile/myprofile_v.dart';
// import 'events_page.dart';

class HomeNavigationPage extends StatefulWidget {
  @override
  _HomeNavigationPageState createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage> {
  int _selectedIndex = 0;
  final sb = SupabaseClass();

  final List<Widget> _pages = [
    ProfileList(), // Browse profiles
    LikesPage(), // People you liked
    MyProfilePage(), // Your profile settings/survey/security
    // EventsPage(), // Events, date spots, etc.
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profiles'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Likes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
          // BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
        ],
      ),
    );
  }
}
