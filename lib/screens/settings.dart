import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/screens/settings_screens/account_settings.dart';
import 'dart:ui';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/chat_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withAlpha(128),
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: const Text('Settings'),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: const Text('Account'),
                      onTap: () {
                        // Navigate to account settings
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AccountSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.green),
                      title: const Text('Notifications'),
                      onTap: () {
                        // Navigate to notification settings
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock, color: Colors.red),
                      title: const Text('Privacy'),
                      onTap: () {
                        // Navigate to privacy settings
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.help, color: Colors.orange),
                      title: const Text('Help & Support'),
                      onTap: () {
                        // Navigate to help & support
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info, color: Colors.purple),
                      title: const Text('About'),
                      onTap: () {
                        // Navigate to about
                      },
                    ),
                    // Logout button
                    ListTile(
                      leading: const Icon(Icons.logout, color: Color.fromARGB(255, 255, 0, 0)),
                      title: const Text('Logout'),
                      onTap: () async {
                        bool confirmLogout = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Logout'),
                              content: const Text('Are you sure you want to logout?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Logout'),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmLogout == true) {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.of(context).pushReplacementNamed('/login');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}