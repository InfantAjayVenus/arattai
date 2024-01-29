import 'package:arattai/widgets/login_form.dart';
import 'package:arattai/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = false;
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              print('DEBUG:CONSTRAINTS: ${constraints.maxWidth}');
              var widthFactor = 1.0;
              if (constraints.maxWidth > 1780) {
                widthFactor = 0.3;
              } else if (constraints.maxWidth > 1440) {
                widthFactor = 0.4;
              } else if (constraints.maxWidth > 1080) {
                widthFactor = 0.5;
              } else if (constraints.maxWidth > 720) {
                widthFactor = 0.7;
              } else if (constraints.maxWidth > 540) {
                widthFactor = 0.8;
              } else if (constraints.maxWidth > 480) {
                widthFactor = 0.9;
              }

              return FractionallySizedBox(
                widthFactor: widthFactor,
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
                                  height: double.infinity,
                                  width: double.infinity,
                                  decoration: !_isLogin
                                      ? BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
