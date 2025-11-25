import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savethedate/ui/core/globals.dart';

class EmojiAvatarPickerSheet extends StatefulWidget {
  final String? currentEmoji;
  final Color currentColor;
  final Function(String emoji, Color color) onAvatarSelected;

  const EmojiAvatarPickerSheet({
    super.key,
    required this.onAvatarSelected,
    this.currentEmoji,
    this.currentColor = const Color(0xFFB3E5FC),
  });

  @override
  State<EmojiAvatarPickerSheet> createState() => _EmojiAvatarPickerSheetState();
}

class _EmojiAvatarPickerSheetState extends State<EmojiAvatarPickerSheet> {
  late String? selectedEmoji;
  late Color selectedColor;

  final List<String> emojis = ['😊', '🎓', '🐱', '🌟', '🔥', '📚', '🥐', '🍕'];
  final List<Color> backgroundColors = [
    const Color.fromARGB(255, 213, 236, 255),
    const Color.fromARGB(255, 255, 213, 228),
    const Color.fromARGB(255, 212, 234, 213),
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.grey[300]!,
  ];

  @override
  void initState() {
    super.initState();
    selectedEmoji = widget.currentEmoji;
    selectedColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFFDF7F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController, // Enable scrolling
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose your Avatar",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CircleAvatar(
                backgroundColor: selectedColor,
                radius: 50,
                child: Text(
                  selectedEmoji ?? '🙂',
                  style: const TextStyle(fontSize: 55),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Pick an Emoji",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children: [
                  ...emojis.map(
                    (emoji) => GestureDetector(
                      onTap: () => setState(() => selectedEmoji = emoji),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor:
                            selectedEmoji == emoji
                                ? Colors.black12
                                : Colors.white,
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _showEmojiInputDialog,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Pick a Background Color",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                children:
                    backgroundColors
                        .map(
                          (color) => GestureDetector(
                            onTap: () => setState(() => selectedColor = color),
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 16,
                              child:
                                  selectedColor == color
                                      ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.black,
                                      )
                                      : null,
                            ),
                          ),
                        )
                        .toList(),
              ),
              const SizedBox(height: 44),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAvatarSelected(
                      selectedEmoji ?? '🙂',
                      selectedColor,
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myRed,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEmojiInputDialog() {
    String customEmoji = '';
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "Add Custom Emoji",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            content: TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(hintText: "Enter emoji"),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  customEmoji = value.characters.first;
                }
              },
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(
                  "Add",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  if (customEmoji.isNotEmpty) {
                    setState(() {
                      emojis.add(customEmoji);
                      selectedEmoji = customEmoji;
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }
}
