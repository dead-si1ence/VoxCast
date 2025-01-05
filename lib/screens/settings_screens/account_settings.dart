import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  Future<Map<String, dynamic>> _fetchUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userData.data() ?? {};
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching user data'));
          }
          final userInfo = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userInfo['image_url'] ??
                    'https://example.com/default-image.png'),
                ),
                const SizedBox(height: 10),
                Text('Username: ${userInfo['username']}'),
                Text('Email: ${userInfo['email']}'),
                const SizedBox(height: 20),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListTile(
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle change password
                  },
                ),
                ListTile(
                  title: const Text('Privacy Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle privacy settings
                  },
                ),
                ListTile(
                  title: const Text('Notification Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle notification settings
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
