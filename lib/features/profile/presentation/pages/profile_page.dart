import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_circle, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Profile Page'),
            SizedBox(height: 8),
            Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
