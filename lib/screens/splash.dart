// Splash screen implementation
// Displayed during app initialization and authentication state checking

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with application title
      appBar: AppBar(
        title: const Text('VoxCast'),
      ),

      // Loading indicator centered on screen
      // Displayed while the app initializes Firebase and checks authentication state
      // This provides visual feedback to users during brief loading periods
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}
