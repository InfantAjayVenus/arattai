import 'dart:io';

import 'package:arattai/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signupKey = GlobalKey<FormState>();
  String email = '';
  String username = '';
  String password = '';
  String passwordReTyped = '';
  File? userProfileImage;

  signUp() async {
    final isFormValid = _signupKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    _signupKey.currentState!.save();

    try {
      final userCreds = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userProfileImage == null) return;

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child('${userCreds.user!.uid}.jpg');

      await storageRef.putFile(userProfileImage!);
      final imageUrl = await storageRef.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCreds.user!.uid)
          .set({'username': username, 'email': email, 'image_url': imageUrl});
    } on FirebaseAuthException catch (error) {
      String errorMessage = 'Authentication Failed';

      if (error.code == 'email-already-in-use') {
        errorMessage = 'Email Already Exists. Try Signing In';
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Form(
        key: _signupKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserImagePicker((pickedImage) {
              setState(() {
                userProfileImage = pickedImage;
              });
            }),
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('E-Mail'),
                hintText: "Enter your E-Mail address",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter valid email';
                }

                return null;
              },
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('User Name'),
                hintText: "Enter your User Name",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter valid name';
                }

                return null;
              },
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                label: Text('Password'),
                hintText: "Enter your password",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter valid password';
                }

                if (value.trim().length < 6) {
                  return 'Password must be at least 6 characters long';
                }

                if (value.trim() != passwordReTyped) {
                  return 'Passwords Do no Match';
                }

                return null;
              },
              onChanged: (value) {
                setState(() {
                  password = value.trim();
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                label: Text('Re-Enter Password'),
                hintText: "Enter your password again",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter valid Password';
                }
                if (value.trim() != password) {
                  return 'Passwords do not match';
                }

                return null;
              },
              onChanged: (value) {
                setState(() {
                  passwordReTyped = value.trim();
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .buttonTheme
                        .colorScheme!
                        .secondaryContainer,
                  ),
                  child: const Text('SignUp'),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
