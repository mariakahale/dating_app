import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/ui/browsing/definitions/profiledef_v.dart';
import 'package:savethedate/ui/browsing/profiledetailpage_v.dart';
import 'package:savethedate/ui/core/alertdialog_info.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/core/snackbar.dart';
import 'package:savethedate/ui/profilesetup/widgets/avatarchoiceselector.dart';
import 'package:savethedate/ui/profilesetup/widgets/emojipicker.dart';
import 'package:savethedate/ui/profilesetup/widgets/hobbiespicker.dart';
import 'package:savethedate/ui/profilesetup/widgets/inviteprompt_v.dart';
import 'package:savethedate/ui/profilesetup/widgets/profilepic_picker_v.dart';
import 'package:savethedate/ui/profilesetup/widgets/progressbar.dart';
import 'package:savethedate/ui/profilesetup/widgets/sociallinkselector.dart';
import 'package:savethedate/ui/profilesetup/widgets/universityverifiedwidget.dart';
import 'package:savethedate/ui/profilesetup/profile_setup_vm.dart';

class ProfileSetupPage extends StatelessWidget {
  const ProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final fb = Provider.of<FirestoreService>(context);
        final vm = ProfileSetupViewModel(fb);
        vm.init();
        return vm;
      },
      child: const _ProfileSetupBody(),
    );
  }
}

class _ProfileSetupBody extends StatelessWidget {
  const _ProfileSetupBody();

  @override
  Widget build(BuildContext context) {
    final fb = Provider.of<FirestoreService>(context);

    final vm = Provider.of<ProfileSetupViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Consumer<ProfileSetupViewModel>(
            builder:
                (context, vm, _) => TextButton(
                  onPressed: () {
                    Provider.of<FirestoreService>(
                      context,
                      listen: false,
                    ).updateAvatarType(
                      avatarType: vm.avatarType,
                      onError: (msg) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(msg)));
                      },
                    );
                    Provider.of<FirestoreService>(
                      context,
                      listen: false,
                    ).updateProfileDoc(
                      discipline: vm.selectedDiscipline ?? "undeclared",
                      onError: (msg) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(msg)));
                      },
                      onSuccess: (msg) {
                        showAppSnackBar(context, "Saved!", width: 100);
                      },
                      name: vm.nameController.text,
                      age: vm.ageController.text,
                      year: vm.yearController.text,
                      showAge: vm.showAge,
                      showYear: vm.showYear,
                      gender: vm.selectedGender,
                      showGender: vm.showGender,
                      showDiscipline: vm.showDiscipline,
                      bio: vm.bioController.text,
                      hobbies: vm.selectedHobbies,
                      socialLink: vm.socialsController.text,
                      showSocialLink: vm.showSocialLink,
                      socialType: vm.selectedSocialType,
                      invitePrompt: vm.selectedInvitePrompt,
                      showInvitePrompt: vm.showInvitePrompt,
                      showHobbies: vm.showHobbies,
                    );
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: myRed,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
          ),
        ],
        title: Text(
          "Step ${vm.step} of 4",
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: vm.controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildStep1(vm, context),
            _buildStep2(vm, context, fb),
            _buildStep3(vm, context),
            _buildPreview(vm, fb, context),
          ],
        ),
      ),
    );
  }

  Widget _buildStep1(ProfileSetupViewModel vm, context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 24),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          OnboardingProgressBar(currentStep: vm.step),
          const SizedBox(height: 30),
          Text(
            "Set Up Your Profile",
            style: GoogleFonts.inter(fontSize: 37, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          /// Name
          TextFormField(
            controller: vm.nameController,
            decoration: inputDecoration(
              "First name or Nickname",
              controller: vm.nameController,
            ),
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: universityEmailStatus(
              isVerified: vm.isUtorVerified,
              context: context,
            ),
          ),
          const SizedBox(height: 16),

          /// Age with checkbox
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: vm.ageController,
                  decoration: inputDecoration(
                    "Age",
                    controller: vm.ageController,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 6),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: vm.showAge,
                  onChanged: (val) => vm.setShowAge(val ?? false),
                  shape: const CircleBorder(),
                  visualDensity: VisualDensity.compact,
                  activeColor: myRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Year with checkbox
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextFormField(
                  controller: vm.yearController,
                  decoration: inputDecoration(
                    "Year",
                    controller: vm.yearController,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 6),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: vm.showYear,
                  onChanged: (val) => vm.setShowYear(val ?? false),
                  shape: const CircleBorder(),
                  visualDensity: VisualDensity.compact,
                  activeColor: myRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Discipline dropdown with checkbox
          Row(
            children: [
              Expanded(
                flex: 5,
                child: DropdownButtonFormField<String>(
                  decoration: inputDecoration(
                    'Discipline',
                    controller: vm.disciplineController,
                  ),
                  value: vm.selectedDiscipline,
                  items:
                      disciplines_list
                          .map(
                            (discipline) => DropdownMenuItem(
                              value: discipline,
                              child: Text(discipline),
                            ),
                          )
                          .toList(),
                  onChanged: (value) => vm.selectedDiscipline = value,
                ),
              ),
              const SizedBox(width: 6),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: vm.showDiscipline,
                  onChanged: (val) => vm.setShowDiscipline(val ?? false),
                  shape: const CircleBorder(),
                  visualDensity: VisualDensity.compact,
                  activeColor: myRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                flex: 5,
                child: DropdownButtonFormField<String>(
                  decoration: inputDecoration(
                    'Gender',
                    controller: vm.genderController,
                  ),
                  value: vm.selectedGender,
                  items:
                      ['Female', 'Male', 'Rather not say', 'Other']
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    vm.selectedGender = value;
                  },
                ),
              ),
              const SizedBox(width: 6),
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: vm.showGender,
                  onChanged: (val) => vm.setShowGender(val ?? false),
                  shape: const CircleBorder(),
                  visualDensity: VisualDensity.compact,
                  activeColor: myRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: 36),
          _nextButton(vm),
        ],
      ),
    );
  }

  Widget _buildStep2(ProfileSetupViewModel vm, context, FirestoreService fb) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24, 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            OnboardingProgressBar(currentStep: vm.step),
            const SizedBox(height: 30),

            Text(
              "Choose your Avatar",
              style: GoogleFonts.inter(
                fontSize: 37,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AvatarSelector(
                          selectedType: vm.avatarType,
                          onTypeSelected: vm.setAvatarType,
                        ),
                        SizedBox(width: 30),

                        if (vm.avatarType == "image")
                          ProfilePicturePicker(
                            fb: fb,
                            fromsupabase_img: vm.imageBytes,
                            onImageSelected: (XFile? imageFile) {},
                          )
                        else
                          GestureDetector(
                            onTap:
                                () => showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder:
                                      (_) => EmojiAvatarPickerSheet(
                                        currentEmoji: vm.selectedEmoji,
                                        currentColor: vm.emojiBackgroundColor,
                                        onAvatarSelected: (emoji, color) {
                                          vm.setEmojiAvatar(emoji, color);
                                        },
                                      ),
                                ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: vm.emojiBackgroundColor,
                              child: Text(
                                vm.selectedEmoji ?? '🙂',
                                style: const TextStyle(fontSize: 45),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const SizedBox(height: 36),

            Row(
              children: [_backButton(vm), SizedBox(width: 20), _nextButton(vm)],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep3(ProfileSetupViewModel vm, context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: [
          Text(
            "Describe Yourself",
            style: GoogleFonts.inter(fontSize: 37, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          OnboardingProgressBar(currentStep: vm.step),
          SizedBox(height: 30),

          /// Hobbies
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [HobbySelector(), const SizedBox(height: 8)],
            ),
          ),

          const SizedBox(height: 20),

          // InvitePromptEditor(
          //   controller: vm.invitePromptController,
          //   onChanged: (val) => vm.notifyListeners(),
          // ),

          // InvitePromptDropdown(
          //   selectedPrompt: vm.selectedInvitePrompt,
          //   onChanged: (val) => vm.setInvitePrompt(val),
          // ),
          InvitePromptCarousel(
            vm: vm,
            selectedPrompt: vm.selectedInvitePrompt,
            onSelected: (val) => vm.setSelectedInvitePrompt(val),
          ),
          const SizedBox(height: 16),
          SocialLinkSelector(vm: vm),
          const SizedBox(height: 8),
          TextFormField(
            controller: vm.socialsController,
            decoration: inputDecoration(
              "Social handle / Phone number (optional)",
              controller: vm.socialsController,
            ),
          ),
          Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: vm.showSocialLink,
                  onChanged: (val) => vm.setShowSocialLink(val ?? false),
                  shape: const CircleBorder(),
                  activeColor: Colors.redAccent,
                ),
              ),
              Expanded(
                child: Text(
                  "Show only when matched (recommended)",
                  style: GoogleFonts.inter(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [_backButton(vm), SizedBox(width: 20), _nextButton(vm)],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPreview(ProfileSetupViewModel vm, FirestoreService fb, context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileDetailPage(
              profile: Profile(
                name: vm.nameController.text,
                age: int.tryParse(vm.ageController.text) ?? 0,
                year: int.tryParse(vm.yearController.text),
                discipline: vm.selectedDiscipline ?? "",
                socialLink: vm.socialsController.text,
                socialType: vm.selectedSocialType,
                hobbies: vm.selectedHobbies,
                bio: vm.bioController.text,
                invitePrompt: vm.selectedInvitePrompt,

                // avatar info
                avatarType: vm.avatarType,
                imageUrl: vm.imageUrl ?? '',
                imageBytes: vm.imageBytes,

                // if using emoji
                emoji: vm.avatarType == 'emoji' ? vm.selectedEmoji : null,
                emojiBgColor:
                    vm.avatarType == 'emoji' ? vm.emojiBackgroundColor : null,

                // you can use Firebase user or dummy for now
                gender: vm.gender,

                isUtorVerified: vm.isUtorVerified,
                showAge: vm.showAge,
                showDiscipline: vm.showDiscipline,
                showGender: vm.showGender,
                showSocialLink: vm.showSocialLink,
                showYear: vm.showYear,
                showHobbies: vm.showHobbies,
                showInvitePrompt: vm.showInvitePrompt,
              ),
            ),

            Row(
              children: [
                _backButton(vm),
                SizedBox(width: 20),
                _submitButton(vm, fb, context),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _nextButton(ProfileSetupViewModel vm) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: myRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: vm.goToNextPage,
        child: const Text(
          "  Next  ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Widget _backButton(ProfileSetupViewModel vm) {
  return Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: vm.goToBackPage,
      child: const Text(
        "  Back  ",
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget _submitButton(ProfileSetupViewModel vm, FirestoreService fb, context) {
  return Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        // backgroundColor: Colors.grey[300],
        backgroundColor: myRed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () async {
        fb.updateProfileDoc(
          discipline: vm.selectedDiscipline ?? "undeclared",
          onError: (msg) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          },
          name: vm.nameController.text,
          age: vm.ageController.text,
          year: vm.yearController.text,
          showAge: vm.showAge,
          showYear: vm.showYear,
          gender: vm.selectedGender,
          showGender: vm.showGender,
          showDiscipline: vm.showDiscipline,
          bio: vm.bioController.text,
          hobbies: vm.hobbies,
          socialLink: vm.socialsController.text,
          showSocialLink: vm.showSocialLink,
          socialType: vm.selectedSocialType,
          invitePrompt: vm.selectedInvitePrompt,
          showInvitePrompt: vm.showInvitePrompt,
          showHobbies: vm.showHobbies,
          onSuccess: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg, textAlign: TextAlign.center),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 280,
              ),
            );
          },
        );
      },
      child: const Text(
        "Submit Profile",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

InputDecoration inputDecoration(
  String label, {
  TextEditingController? controller,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.grey),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: myRed, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey, width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    filled: true,
    fillColor: Colors.white,
  );
}
