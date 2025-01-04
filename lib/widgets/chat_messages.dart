// Chat messages display component
// Handles real-time message streaming and rendering of message bubbles

import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    // Get reference to currently authenticated user
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      // Create real-time stream of chat messages from Firestore
      // Messages are ordered by creation timestamp in descending order
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        // Display loading indicator while initializing stream
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Handle case when no messages exist
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No messages found.'),
          );
        }

        // Handle potential stream errors
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('Something went wrong...'),
          );
        }

        final loadedMessages = chatSnapshots.data!.docs;

        // Create scrollable list of messages
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true, // Display newest messages at the bottom
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();

            // Check if this message is part of a sequence from the same user
            final nextChatMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage['userId'] : null;
            final nextUserIsSame = nextMessageUserId == currentMessageUserId;

            // Render appropriate message bubble based on sequence position
            if (nextUserIsSame) {
              // Subsequent message in a sequence
              return MessageBubble.next(
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            } else {
              // First message in a sequence - includes user details
              return MessageBubble.first(
                userImage: chatMessage['userImage'],
                username: chatMessage['username'],
                message: chatMessage['text'],
                isMe: authenticatedUser.uid == currentMessageUserId,
              );
            }
          },
        );
      },
    );
  }
}
