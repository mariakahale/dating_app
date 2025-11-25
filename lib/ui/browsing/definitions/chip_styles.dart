// lib/ui/theme/chip_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/core/globals.dart';

class AppChipStyles {
  static Chip hobby(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.pinkAccent,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  static Chip removeHobby(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      backgroundColor: myRed,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      deleteIcon: const Icon(Icons.close, size: 18, color: Colors.white),
      onDeleted: onRemove,
    );
  }

  // Choice chip for selecting options:
  static ChoiceChip choiceHobby({
    required String label,
    required bool selected,
    required void Function(bool) onSelected,
  }) {
    return ChoiceChip(
      label: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : Colors.black,
        ),
      ),
      selected: selected,
      selectedColor: myRed,
      backgroundColor: Colors.grey[200],
      onSelected: onSelected,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  // Add more styles as needed:
  static Chip club(String label) {
    return Chip(label: Text(label), backgroundColor: Colors.lightBlue[100]);
  }
}
