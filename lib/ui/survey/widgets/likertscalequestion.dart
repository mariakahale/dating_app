// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LikertScaleQuestion extends StatelessWidget {
  final String question;
  final int? selectedValue;
  final Function(int?) onChanged;

  const LikertScaleQuestion({
    super.key,
    required this.question,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          children: List.generate(6, (index) {
            final value = index + 1;
            return ChoiceChip(
              label: Text(value.toString()),
              selected: selectedValue == value,
              onSelected: (_) => onChanged(value),
              selectedColor: const Color.fromARGB(255, 255, 113, 103),
              backgroundColor: Colors.grey[200],
            );
          }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
