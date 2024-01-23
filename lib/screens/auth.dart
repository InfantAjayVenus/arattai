import 'package:arattai/widgets/login_form.dart';
import 'package:arattai/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;
  _AuthScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withAlpha(175),
              Theme.of(context).primaryColor.withAlpha(150),
              Theme.of(context).primaryColor.withOpacity(0.5),
              Theme.of(context).primaryColor.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(10),
            clipBehavior: Clip.hardEdge,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: !_isLogin
                                ? BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .secondaryContainer,
                                  )
                                : null,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = true;
                                });
                              },
                              child: const Text("Login"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            decoration: _isLogin
                                ? BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .secondaryContainer,
                                  )
                                : null,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = false;
                                });
                              },
                              child: const Text("SignUp"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _isLogin ? const LoginForm() : const SignUpForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
