import 'package:flutter/material.dart';
import 'package:savethedate/ui/core/globals.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onToggle;

  const LikeButton({required this.isLiked, required this.onToggle, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? myRed : myRed,
      ),
      onPressed: onToggle,
    );
  }
}

// class LikeButton extends StatefulWidget {
//   final ValueChanged<bool>? onChanged;
//   final VoidCallback? onLike; // NEW

//   const LikeButton({super.key, this.onChanged, this.onLike});

//   @override
//   State<LikeButton> createState() => _LikeButtonState();
// }

// class _LikeButtonState extends State<LikeButton> {
//   bool isLiked = false;

//   void toggleLike() {
//     setState(() {
//       isLiked = !isLiked;
//     });

//     if (widget.onChanged != null) {
//       widget.onChanged!(isLiked);
//     }

//     if (isLiked && widget.onLike != null) {
//       widget.onLike!(); // only show snackbar when liked
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: toggleLike,
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 6,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(
//           isLiked ? Icons.favorite : Icons.favorite_border,
//           color: myRed,
//           size: 20,
//         ),
//       ),
//     );
//   }
// }
