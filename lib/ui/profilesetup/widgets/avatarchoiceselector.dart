import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/globals.dart';

class AvatarSelector extends StatelessWidget {
  final String selectedType;
  final void Function(String) onTypeSelected;

  const AvatarSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      direction: Axis.vertical,
      verticalDirection: VerticalDirection.up,
      isSelected: [selectedType == "image", selectedType == "emoji"],
      onPressed: (index) {
        final type = index == 0 ? "image" : "emoji";
        onTypeSelected(type);
      },
      borderRadius: BorderRadius.circular(12),
      selectedColor: myRed,
      color: Colors.black,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.image),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.emoji_emotions),
        ),
      ],
    );
  }
}
