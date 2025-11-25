import 'package:flutter/material.dart';

class LikeManager with ChangeNotifier {
  final eventId = 1;

  // final Map<int, Set<String>> _likesByEvent = {};

  // bool isLiked(int eventId, String userEmail) {
  //   return _likesByEvent[eventId]?.contains(userEmail) ?? false;
  // }
  bool isLiked(int eventId, String profileId) {
    // No-op for now — always return false
    return false;
  }

  // void toggleLike(int eventId, String userEmail) {
  //   final likes = _likesByEvent.putIfAbsent(eventId, () => {});
  //   if (!likes.add(userEmail)) {
  //     likes.remove(userEmail); // if already there, remove
  //   }
  //   notifyListeners();
  // }
  void toggleLike(int eventId, String profileId) {
    // No-op for now — do nothing
  }
}
