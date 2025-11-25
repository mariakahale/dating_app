import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';

class Profile {
  final String name;
  final int age;
  final String bio;
  final String? imageUrl;
  final String discipline;
  final int? year;

  final List<String>? hobbies;
  final List<String>? clubs;
  final String? socialLink;
  final String? socialType;
  final String? secondaryImageUrl;
  final String? invitePrompt;
  final Color? detailPageBackgroundColor;

  final Uint8List? imageBytes; // For local images

  // Firebase-specific
  final String avatarType; // "emoji" or "photo"
  final String? emoji;
  final Color? emojiBgColor;
  final String? gender;
  final bool isUtorVerified;

  // Display controls
  final bool showAge;
  final bool showDiscipline;
  final bool showGender;
  final bool showSocialLink;
  final bool showYear;
  final bool showHobbies;
  final bool showInvitePrompt;

  final List<ProfileSectionType> visibleSections;

  Profile({
    required this.name,
    required this.age,
    required this.bio,
    required this.imageUrl,
    required this.discipline,
    required this.avatarType,
    required this.gender,
    required this.isUtorVerified,
    required this.showAge,
    required this.showDiscipline,
    required this.showGender,
    required this.showSocialLink,
    required this.showYear,
    required this.showHobbies,
    required this.showInvitePrompt,
    this.year,
    this.emoji,
    this.emojiBgColor,
    this.socialLink,
    this.socialType,
    this.hobbies,
    this.clubs,
    this.secondaryImageUrl,
    this.invitePrompt,
    this.detailPageBackgroundColor,
    this.visibleSections = const [],
    this.imageBytes,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      age: int.tryParse(json['age']) ?? -1,
      bio: json['bio'] ?? '',
      imageUrl: json['imagePath'] ?? '',
      discipline: json['discipline'] ?? '',
      year: json['year'],
      socialLink: json['socialLink'],
      socialType: json['socialType'],
      hobbies: (json['hobbies'] as List?)?.map((e) => e.toString()).toList(),
      clubs: null, // Not in Firebase currently
      secondaryImageUrl: null,
      invitePrompt: json['invitePrompt'],

      detailPageBackgroundColor:
          json['emojiBgColor'] != null ? Color(json['emojiBgColor']) : null,
      visibleSections: const [], // You can generate based on logic
      // Firebase-specific
      avatarType: json['avatarType'] ?? 'emoji',
      emoji: json['emoji'],
      emojiBgColor:
          json['emojiBgColor'] != null ? Color(json['emojiBgColor']) : null,
      gender: json['gender'] ?? '',
      isUtorVerified: json['isUtorVerified'] ?? false,

      // Display flags
      showAge: json['showAge'] ?? false,
      showDiscipline: json['showDiscipline'] ?? false,
      showGender: json['showGender'] ?? false,
      showSocialLink: json['showSocialLink'] ?? false,
      showYear: json['showYear'] ?? false,
      showHobbies: json['showHobbies'] ?? false,
      showInvitePrompt: json['showInvitePrompt'] ?? false,
    );
  }
}

enum ProfileSectionType {
  hobbies,
  clubs,
  favoriteMovie,
  secondaryImage,
  invitePrompt,
}
