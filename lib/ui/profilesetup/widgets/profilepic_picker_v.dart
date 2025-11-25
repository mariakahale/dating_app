import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savethedate/services/firestore_service.dart';
import 'package:savethedate/services/supabase.dart';
import 'package:savethedate/ui/core/globals.dart';

class ProfilePicturePicker extends StatefulWidget {
  final Function(XFile imageFile) onImageSelected;
  final Uint8List? fromsupabase_img;
  final XFile? selectedImage;
  final String? path;
  // ✅ Add this for existing Supabase image URL
  final FirestoreService fb;
  final String? fileName;

  const ProfilePicturePicker({
    this.fromsupabase_img,
    super.key,
    required this.fb,
    this.fileName,
    required this.onImageSelected,
    this.selectedImage,
    this.path, // ✅ Initialize this
  });

  @override
  State<ProfilePicturePicker> createState() => _ProfilePicturePickerState();
}

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  XFile? _localSelectedImage;

  @override
  void initState() {
    super.initState();
    _localSelectedImage = widget.selectedImage;
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final cropped = await ImageCropper().cropImage(
        sourcePath: picked.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: myRed,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
        ],
      );
      if (cropped != null) {
        final croppedFile = XFile(cropped.path);
        setState(() {
          _localSelectedImage = croppedFile;
        });
        widget.onImageSelected(croppedFile);
      }
    }
  }

  Future<String?> uploadImagetoSupabase() async {
    if (_localSelectedImage == null) return null;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final path = 'uploads/$fileName.jpg';

    try {
      final client = SupabaseClass().getClient();
      final response = await client.storage
          .from('images')
          .upload(path, File(_localSelectedImage!.path));

      if (response.isEmpty) {
        print("❌ Upload failed: empty response");
        return null;
      }

      return path;
    } catch (e) {
      print("Upload to Supabase failed: $e");
      return null;
    }
  }

  Widget uploadButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: myRed,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed:
            _localSelectedImage == null
                ? null
                : () async {
                  final url = await uploadImagetoSupabase();
                  if (url != null) {
                    await widget.fb.uploadImageURLtoFirebase(url);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Uploaded successfully',
                          textAlign: TextAlign.center,
                        ),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 250,
                      ),
                    );
                  }
                },
        child: const Text(
          "Upload",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget profileImageDisplay() {
    if (_localSelectedImage != null) {
      // User selected new image
      return Image.file(
        File(_localSelectedImage!.path),
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      );
    } else if (widget.fromsupabase_img != null) {
      // Use existing image from Supabase
      return Image.memory(
        widget.fromsupabase_img!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,

        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 32, color: Colors.white);
        },
      );
    } else {
      // Fallback default
      return const Icon(Icons.add_a_photo, size: 32, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 120,
              height: 120,
              color: Colors.grey[300],
              child: profileImageDisplay(),
            ),
          ),
          const SizedBox(height: 12),
          uploadButton(),
        ],
      ),
    );
  }
}
