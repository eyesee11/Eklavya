import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Register Page'),
            SizedBox(height: 8),
            Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
