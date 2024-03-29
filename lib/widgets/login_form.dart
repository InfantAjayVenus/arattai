import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool invalidCreds = false;

  login() async {
    final isFormValid = _loginKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      return;
    }
    _loginKey.currentState?.save();
    setState(() {
      invalidCreds = false;
    });

    try {
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        setState(() {
          invalidCreds = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Form(
        key: _loginKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('E-Mail'),
                hintText: "Enter your E-Mail address",
              ),
              validator: (value) {
                RegExp exp = RegExp(
                    r'(^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$)');
                if (value == null ||
                    value.trim().isEmpty ||
                    !exp.hasMatch(value.trim())) {
                  return 'Please enter valid email';
                }

                return null;
              },
              onChanged: (value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Password'),
                hintText: "Enter your password",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter valid password';
                }

                if (value.trim().length < 6) {
                  return "Password must be longer than 6 characters";
                }

                return null;
              },
              onChanged: (value) {
                setState(() {
                  password = value.trim();
                });
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .buttonTheme
                        .colorScheme!
                        .secondaryContainer,
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(
                  width: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    _loginKey.currentState?.reset();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (invalidCreds)
              Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  'Invalid E-Mail or Password'),
          ],
        ),
      ),
    );
  }
}
