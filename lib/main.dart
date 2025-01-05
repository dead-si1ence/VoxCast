// Main entry point for the VoxCast chat application
// This file handles Firebase initialization and app theme configuration

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/screens/splash.dart';

// Initialize Firebase and start the application
void main() async {
  // Ensure Flutter bindings are initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with platform-specific options
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
      
      // Application theme configuration
      theme: ThemeData(
        // Set dark mode as the base theme
        brightness: Brightness.dark,
        
        // Define primary color scheme
        primaryColor: const Color.fromARGB(255, 103, 58, 183), // Deep purple
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color.fromARGB(255, 103, 58, 183),
          secondary: const Color.fromARGB(255, 59, 59, 59),
          tertiary: const Color.fromARGB(255, 0, 150, 136),
          surface: const Color.fromARGB(255, 37, 37, 37),
        ),
        
        // Configure background and card colors
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 18, 18),
        cardColor: const Color.fromARGB(255, 30, 30, 30),
        dividerColor: const Color.fromARGB(255, 45, 45, 45),
        
        // Button theme configuration
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromARGB(255, 103, 58, 183),
          textTheme: ButtonTextTheme.primary,
        ),
        
        // Text theme configuration for consistent typography
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 179, 179, 179), fontSize: 14),
        ),
        
        // AppBar theme configuration
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 30, 30, 30),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        
        // Icon theme configuration
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 233, 30, 99)),
        
        // Input field decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 37, 37, 37),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 103, 58, 183)),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 103, 58, 183)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 233, 30, 99)),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 179, 179, 179)),
          hintStyle: const TextStyle(color: Color.fromARGB(255, 128, 128, 128)),
        ),
      ),
      
      debugShowCheckedModeBanner: false,
      
      // Authentication state management using StreamBuilder
      home: StreamBuilder(
        // Listen to Firebase authentication state changes
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          // Show splash screen while checking authentication state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }

          // Navigate to chat screen if user is authenticated
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          
          // Show authentication screen if user is not authenticated
          return const AuthScreen();
        },
      ),
    );
  }
}