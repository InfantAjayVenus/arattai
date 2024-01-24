import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.onPick, {super.key});

  final void Function(File pickedImage) onPick;

  @override
  State<StatefulWidget> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? pickedImageFile;

  pickImage() async {
    final pickedImageData = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImageData == null) return;

    setState(() {
      pickedImageFile = File(pickedImageData.path);
    });

    widget.onPick(pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundImage:
              pickedImageFile != null ? FileImage(pickedImageFile!) : null,
        ),
        TextButton.icon(
            onPressed: () {
              pickImage();
            },
            icon: const Icon(Icons.image_rounded),
            label: const Text('Add Image')),
      ],
    );
  }
}
