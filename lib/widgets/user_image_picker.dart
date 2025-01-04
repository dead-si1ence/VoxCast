// User image picker component
// Handles profile image selection and preview during user registration

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.onPickImage,
  });

  // Callback function to handle selected image
  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  // Handle image selection process
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50, // Compress image for storage efficiency
      maxWidth: 150, // Limit image dimensions
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    // Notify parent widget of selected image
    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image preview in circular avatar
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        ),
        // Image selection button
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
