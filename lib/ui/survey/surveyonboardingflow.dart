// A refined onboarding survey UI with branding, scrubbable progress and polished style

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/core/globals.dart';
import 'package:savethedate/ui/survey/questionpages/attachmentstyle.dart';

const backgroundColor = Color(0xFFFDF7F8);

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final PageController _controller = PageController();
  int currentStep = 0;

  final List<String> categories = [
    "Attachment Style",
    "Biographics",
    "Academics",
    "Career",
    "Faith & Values",
    "Relationships",
    "Preferences",
  ];

  void goToStep(int index) {
    _controller.jumpToPage(index);
    setState(() => currentStep = index);
  }

  Widget buildProgressHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: ElevatedButton(
                onPressed: () => goToStep(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentStep == index ? myRed : Colors.white,
                  foregroundColor:
                      currentStep == index ? Colors.white : Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  categories[index],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestion(String question, Widget input) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        input,
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Survey",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildProgressHeader(),
            const Divider(),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => currentStep = i),
                children: [
                  Attachmentstyle(),
                  BiographicsSection(),
                  AcademicsSection(),
                  CareerSection(),
                  FaithSection(),
                  RelationshipsSection(),
                  PreferencesSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BiographicsSection extends StatelessWidget {
  const BiographicsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            "Biographics",
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Ethnicity",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Height (in cm)",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}

class AcademicsSection extends StatelessWidget {
  const AcademicsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Academics section placeholder"));
  }
}

class CareerSection extends StatelessWidget {
  const CareerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Career section placeholder"));
  }
}

class FaithSection extends StatelessWidget {
  const FaithSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Faith & Values section placeholder"));
  }
}

class RelationshipsSection extends StatelessWidget {
  const RelationshipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Relationships section placeholder"));
  }
}

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Preferences section placeholder"));
  }
}
