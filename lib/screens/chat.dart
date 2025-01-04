// Main chat screen implementation
// Displays chat messages and handles user interactions

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with settings and logout options
      appBar: AppBar(
        title: const Text(
          'VoxCast',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          // Settings button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Theme.of(context).colorScheme.primary,
          ),
          // Logout button
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),

      // Main chat interface
      body: Stack(
        children: [
          // Chat background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/chat_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Chat messages and input field
          const Column(
            children: [
              // Messages list (scrollable)
              Expanded(
                child: ChatMessages(),
              ),
              // Message input field
              NewMessage(),
            ],
          ),
        ],
      ),
    );
  }
}
