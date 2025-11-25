import 'package:flutter/material.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/ui/browsing/definitions/profiledef_v.dart';

class ProfileListViewModel extends ChangeNotifier {
  List<Profile> _profiles = [];

  List<Profile> get profiles => _profiles;

  ProfileListViewModel() {
    FirestoreService().getProfiles();
  }

  // void loadProfiles() {
  //   _profiles = [21@21
  //     Profile(
  //       year: 3,
  //       userId: 1,
  //       name: "Emma",
  //       age: 21,
  //       imageUrl: "https://i.pravatar.cc/300?img=1",
  //       intro: "📚☕🌅",
  //       hobbies: ["Reading", "Hiking", "Thrifting", "Photography"],
  //       clubs: ["Psych Society", "Creative Writing Club"],
  //       favoriteMovie: "Little Women",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=10",
  //       discipline: "Psychology",
  //     ),
  //     Profile(
  //       year: 3,

  //       userId: 2,
  //       name: "Liam",
  //       age: 23,
  //       imageUrl: "https://i.pravatar.cc/300?img=2",
  //       intro: "🚗🔧🎮",
  //       hobbies: ["3D Printing", "Gaming", "Basketball"],
  //       clubs: ["Robotics Club", "Car Enthusiasts"],
  //       favoriteMovie: "Ford v Ferrari",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=20",
  //       invitePrompt: "Want to grab bubble tea and talk about cars?",
  //       discipline: "Mechanical Engineering",
  //     ),
  //     Profile(
  //       year: 2,

  //       userId: 3,
  //       name: "Sophia",
  //       age: 20,
  //       imageUrl: "https://i.pravatar.cc/300?img=3",
  //       intro: "🗓️🥂🧁",
  //       hobbies: ["Planning", "Journaling", "Sushi nights"],
  //       clubs: ["Women in Business", "Toastmasters"],
  //       favoriteMovie: "The Intern",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=11",
  //       invitePrompt: "Join me for a morning coffee planning session?",
  //       discipline: "Business",
  //     ),
  //     Profile(
  //       year: 2,
  //       userId: 4,
  //       name: "Noah",
  //       age: 22,
  //       imageUrl: "https://i.pravatar.cc/300?img=4",
  //       intro: "🌿📺🧪",
  //       hobbies: ["Bird Watching", "Cooking", "Documentaries"],
  //       clubs: ["Pre-Med Society"],
  //       favoriteMovie: "My Octopus Teacher",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=21",
  //       discipline: "Biology",
  //     ),
  //     Profile(
  //       year: 2,
  //       userId: 5,
  //       name: "Ava",
  //       age: 19,
  //       imageUrl: "https://i.pravatar.cc/300?img=5",
  //       intro: "📔🧘‍♀️✨",
  //       hobbies: ["Journaling", "Pilates", "Pinterest boards"],
  //       clubs: ["Photography Society"],
  //       favoriteMovie: "La La Land",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=12",
  //       invitePrompt: "Study date at a cozy library nook?",
  //       discipline: "Media Studies",
  //     ),
  //     Profile(
  //       year: 4,
  //       userId: 7,
  //       name: "Ethan",
  //       age: 24,
  //       imageUrl: "https://i.pravatar.cc/300?img=6",
  //       intro: "🤖💻♟️",
  //       hobbies: ["AI Research", "Running", "Chess"],
  //       clubs: ["Tech Society", "Hackathons"],
  //       favoriteMovie: "The Social Network",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=22",
  //       discipline: "Computer Science",
  //       socialLink: '@instagrammer',
  //     ),
  //     Profile(
  //       year: 4,
  //       userId: 8,
  //       name: "Isabella",
  //       age: 21,
  //       imageUrl: "https://i.pravatar.cc/300?img=7",
  //       intro: "👗🧵☕",
  //       hobbies: ["Sewing", "Thrifting", "Cafés"],
  //       clubs: ["Sustainable Fashion"],
  //       favoriteMovie: "Clueless",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=13",
  //       invitePrompt: "Vintage market + iced oat milk latte?",
  //       discipline: "Fashion Design",
  //     ),
  //     Profile(
  //       year: 4,
  //       userId: 9,
  //       name: "James",
  //       age: 20,
  //       imageUrl: "https://i.pravatar.cc/300?img=8",
  //       intro: "🧠🎤🧗",
  //       hobbies: ["Debating", "Stand-up Comedy", "Rock Climbing"],
  //       clubs: ["Debate Society", "Comedy Club"],
  //       favoriteMovie: "The Matrix",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=23",
  //       discipline: "Philosophy",
  //     ),
  //     Profile(
  //       year: 4,
  //       userId: 10,
  //       name: "Maya",
  //       age: 22,
  //       imageUrl: "https://i.pravatar.cc/300?img=9",
  //       intro: "🌿🎶✍️",
  //       hobbies: ["Poetry", "Plant Care", "Indie Music"],
  //       clubs: ["Poetry Slam", "Music Lovers Club"],
  //       favoriteMovie: "Pride & Prejudice",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=14",
  //       invitePrompt: "Coffee + Spotify playlist swap?",
  //       discipline: "English Literature",
  //     ),
  //     Profile(
  //       year: 4,
  //       name: "Arjun",
  //       age: 23,
  //       imageUrl: "https://i.pravatar.cc/300?img=15",
  //       intro: "💻🍰🎲",
  //       hobbies: ["Coding", "Baking", "Board Games"],
  //       clubs: ["Baking Club", "Developers Guild"],
  //       favoriteMovie: "Everything Everywhere All At Once",
  //       secondaryImageUrl: "https://i.pravatar.cc/300?img=24",
  //       discipline: "Computer Science",
  //     ),
  //   ];
  //   notifyListeners();
  // }
}
