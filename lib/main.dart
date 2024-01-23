import 'package:arattai/firebase_options.dart';
import 'package:arattai/screens/auth.dart';
import 'package:arattai/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("DEBUG: FIREBASE_INIT_ERROR: $e");
  }

  runApp(const ArattaiApp());
}

class ArattaiApp extends StatelessWidget {
  const ArattaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 117, 221, 181)),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const ChatScreen();
            }

            return const AuthScreen();
          }),
    );
  }
}
