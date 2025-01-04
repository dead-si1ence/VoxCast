// New message input component
// Handles message composition and sending to Firestore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  // Controller for managing text input
  final _messageController = TextEditingController();

  @override
  void dispose() {
    // Clean up controller when widget is disposed
    _messageController.dispose();
    super.dispose();
  }

  // Handle message submission
  void _submitMessage() async {
    final enteredMessage = _messageController.text;

    // Validate message content
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    // Clear focus and input field
    FocusScope.of(context).unfocus();
    _messageController.clear();

    // Get current user and their profile data
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    // Store message in Firestore with metadata
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 2,
        bottom: 14,
      ),
      child: Opacity(
        opacity: 0.8,
        child: Row(
          children: [
            // Message input field
            Expanded(
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                minLines: 1,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Send a message...',
                ),
              ),
            ),
            // Send button
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.send),
              onPressed: _submitMessage,
            ),
          ],
        ),
      ),
    );
  }
}
