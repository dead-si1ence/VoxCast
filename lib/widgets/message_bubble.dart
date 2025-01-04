// Message bubble widget for displaying individual chat messages
// Supports different styles for user's own messages and received messages

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  // Constructor for first message in a sequence
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // Constructor for subsequent messages in a sequence
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  // Message properties
  final bool isFirstInSequence;
  final String? userImage;
  final String? username;
  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // User avatar display for first message in sequence
        if (userImage != null)
          Positioned(
            top: 15,
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage!),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),

        // Message content container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            // Align messages based on sender
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // Spacing for first message in sequence
                  if (isFirstInSequence) const SizedBox(height: 18),

                  // Username display for first message
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  // Message bubble with text
                  Container(
                    decoration: BoxDecoration(
                      // Different colors for sent vs received messages
                      color: isMe
                          ? theme.colorScheme.primary.withAlpha(175)
                          : theme.colorScheme.secondary.withAlpha(225),
                      // Custom border radius for message sequence positioning
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        height: 1.3,
                        color: isMe ? Colors.white : Colors.white,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
