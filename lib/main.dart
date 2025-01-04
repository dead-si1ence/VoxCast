import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoxCast',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromARGB(255, 0, 0, 0),
      //   ),
      // ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color.fromARGB(255, 103, 58, 183), // Deep purple
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color.fromARGB(255, 103, 58, 183),
          secondary: const Color.fromARGB(255, 59, 59, 59),
          tertiary: const Color.fromARGB(255, 0, 150, 136),
          surface: const Color.fromARGB(255, 37, 37, 37),
        ),
        // theme: ThemeData(
        // useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(
        // seedColor: const Color.fromARGB(255, 0, 0, 0),
        // ),
        // ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
        cardColor: const Color.fromARGB(255, 30, 30, 30),
        dividerColor: const Color.fromARGB(255, 45, 45, 45),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromARGB(255, 103, 58, 183),
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(
              color: Color.fromARGB(255, 179, 179, 179), fontSize: 14),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 30, 30, 30),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 233, 30, 99)), // Pink icons
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 37, 37, 37),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 103, 58, 183)),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 103, 58, 183)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 233, 30, 99)),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 179, 179, 179)),
          hintStyle: const TextStyle(color: Color.fromARGB(255, 128, 128, 128)),
        ),
      ),
// theme: ThemeData.from(
// colorScheme: ColorScheme.fromSeed(
// brightness: Brightness.dark,
// seedColor: const Color.fromARGB(255, 176, 161, 219),
// primary: const Color.fromARGB(255, 112, 88, 184),
// surface: const Color.fromARGB(255, 58, 58, 58),
// ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
