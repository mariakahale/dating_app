import 'package:flutter/material.dart';
import 'package:savethedate/ui/browsing/definitions/profiledef_v.dart';

class ProfileDetailViewModel extends ChangeNotifier {
  final Profile profile;

  ProfileDetailViewModel({required this.profile});

  Color get backgroundColor =>
      profile.detailPageBackgroundColor ?? const Color(0xFFFDF6F9);

  bool shouldShow(ProfileSectionType type) =>
      profile.visibleSections.contains(type);
}
