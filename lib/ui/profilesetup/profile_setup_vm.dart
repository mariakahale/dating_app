import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/services/supabase.dart';
import 'package:savethedate/ui/core/globals.dart';

class ProfileSetupViewModel extends ChangeNotifier {
  final PageController controller = PageController();
  final FirestoreService fb;

  ///
  // AvatarType avatarType = AvatarType.image;
  String avatarType = "image";
  String? selectedEmoji;
  Color emojiBackgroundColor = Colors.lightBlue[100]!;
  String? imageUrl;
  Uint8List? imageBytes;

  void setAvatarType(String type) {
    avatarType = type;
    notifyListeners();
  }

  void setEmojiAvatar(String emoji, Color color) {
    selectedEmoji = emoji;
    emojiBackgroundColor = color;
    notifyListeners();
  }

  ///
  int step = 1;

  Map<String, dynamic>? userData;
  //boolean show values

  bool showAge = true;
  bool showDiscipline = true;
  bool showNationality = true;
  bool showGender = true;
  bool showYear = true;
  bool showSocialLink = true;
  bool showHobbies = true;
  bool showInvitePrompt = true;
  // Form Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController hobbyInputController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController socialsController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController disciplineController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController invitePromptController = TextEditingController();

  String? selectedDiscipline;
  String? selectedAge;
  String? selectedYear;
  String? selectedGender;
  String? selectedBio;
  String? selectedName;

  String? selectedSocials;
  String? selectedInvitePrompt;
  String? selectedSocialType;
  bool isUtorVerified = false;
  String? gender;
  List<String> hobbies = [];

  String? selected_avatarType;
  String? selectedImagePath;

  ProfileSetupViewModel(this.fb);

  void setShowAge(bool val) {
    showAge = val;
    notifyListeners();
  }

  void setShowSocialLink(bool val) {
    showSocialLink = val;
    notifyListeners();
  }

  void setSelectedInvitePrompt(String val) {
    selectedInvitePrompt = val;
    notifyListeners();
  }

  void setShowHobbies(bool val) {
    showHobbies = val;
    notifyListeners();
  }

  void setShowInvitePrompt(bool val) {
    showInvitePrompt = val;
    notifyListeners();
  }

  void setShowYear(bool val) {
    showYear = val;
    notifyListeners();
  }

  void setShowDiscipline(bool val) {
    showDiscipline = val;
    notifyListeners();
  }

  void setShowNationality(bool val) {
    showNationality = val;
    notifyListeners();
  }

  void setShowGender(bool val) {
    showGender = val;
    notifyListeners();
  }

  void UpdatedefaultValues() async {
    selectedDiscipline = userData?["discipline"];
    selectedName = userData?["name"];
    selectedAge = userData?["age"];
    selectedYear = userData?["year"];
    selectedGender = userData?["gender"];
    selectedBio = userData?["bio"];
    selectedSocials = userData?["socialLink"];
    selectedSocialType = userData?["socialType"];
    selectedInvitePrompt = userData?["invitePrompt"];
    selectedHobbies = userData?["hobbies"]?.cast<String>() ?? [];

    showAge = userData?["showAge"] ?? true;
    showYear = userData?["showYear"] ?? true;
    showDiscipline = userData?["showDiscipline"] ?? true;
    showGender = userData?["showGender"] ?? true;
    showSocialLink = userData?["showSocialLink"] ?? true;
    showHobbies = userData?["showHobbies"] ?? true;
    showInvitePrompt = userData?["showInvitePrompt"] ?? true;
    isUtorVerified = userData?["isUtorVerified"];

    selected_avatarType = userData?["avatarType"];

    // 🟡 Step 1: Get imagePath from Firestore (already done)
    final String? imagePath = userData?["imagePath"];

    // 🟢 Step 2: Use Supabase client to get public URL
    if (imagePath != null && imagePath.isNotEmpty) {
      try {
        imageUrl = imagePath;
        print("✅ Supabase image URL: $imageUrl");
      } catch (e) {
        print("❌ Error getting Supabase image URL: $e");
      }
    }

    // Populate hobbies safely
    final List<dynamic>? rawHobbies = userData?["hobbies"];
    if (rawHobbies != null) {
      selectedHobbies = rawHobbies.cast<String>();
    } else {
      selectedHobbies = [];
    }

    // Set form controllers
    if (selectedName?.isNotEmpty ?? false) {
      nameController.text = selectedName!;
    }
    if (selectedAge?.isNotEmpty ?? false) {
      ageController.text = selectedAge!;
    }
    if (selectedYear?.isNotEmpty ?? false) {
      yearController.text = selectedYear!;
    }

    if (selectedGender?.isNotEmpty ?? false) {
      final validGenders = ['Female', 'Male', 'Rather not say', 'Other'];
      genderController.text =
          validGenders.contains(selectedGender)
              ? selectedGender!
              : 'Select Gender';
    }
    if (selectedBio?.isNotEmpty ?? false) {
      bioController.text = selectedBio!;
    }
    if (selectedSocials?.isNotEmpty ?? false) {
      socialsController.text = selectedSocials!;
    }

    if (selectedInvitePrompt?.isNotEmpty ?? false) {
      invitePromptController.text = selectedInvitePrompt!;
    }
    notifyListeners();
  }

  Future<void> getImageUrl() async {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      try {
        imageBytes = await SupabaseClass().getImgFile_fromSupabase(imageUrl!);
        notifyListeners(); // triggers widget rebuild
      } catch (e) {
        print('Failed to load image: $e');
      }
    } else {
      print("Image URL is null or empty");
    }
  }

  Future<void> init() async {
    final query = await fb.loadUserData(); // load Firestore query

    if (query != null) {
      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        userData =
            snapshot.docs.first
                .data(); // get the actual user data as Map<String, dynamic>
        UpdatedefaultValues();
      } else {
        print("query is null");
      }
    }

    getImageUrl();

    notifyListeners();

    controller.addListener(() {
      int page = controller.page?.round() ?? 0;
      if (step != page + 1) {
        step = page + 1;
        notifyListeners();
      }
    });
  }

  Future<void> print_userdatalist(futureUserDataList) async {
    final query = await futureUserDataList;

    if (query == null) {
      print('Query is null');
      return;
    }

    final querySnapshot = await query.get();

    for (var doc in querySnapshot.docs) {
      print(doc.data()); // prints Map<String, dynamic>
    }
  }

  void setGender(String? value) {
    gender = value;
    notifyListeners();
  }

  void setCustomInvitePrompt(String val) {
    invitePromptController.text = val;
    notifyListeners();
  }

  List<String> selectedHobbies = [];
  String currentInput = "";

  void addHobby(String hobby) {
    if (!selectedHobbies.contains(hobby)) {
      selectedHobbies.add(hobby);
      notifyListeners();
    }
  }

  void removeHobby(String hobby) {
    selectedHobbies.remove(hobby);
    notifyListeners();
  }

  void updateHobbyInput(String input) {
    currentInput = input;
    notifyListeners();
  }

  List<String> get filteredSuggestions {
    if (currentInput.isEmpty) return [];
    final lowerInput = currentInput.toLowerCase();
    return allHobbies
        .where(
          (hobby) =>
              hobby.toLowerCase().contains(lowerInput) &&
              !selectedHobbies.contains(hobby),
        )
        .toList();
  }

  void toggleHobby(String hobby, bool selected) {
    if (selected) {
      hobbies.add(hobby);
    } else {
      hobbies.remove(hobby);
    }
    notifyListeners();
  }

  void goToNextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToBackPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void setSelectedSocialType(String platform) {
    selectedSocialType = platform;
    notifyListeners();
  }
}
