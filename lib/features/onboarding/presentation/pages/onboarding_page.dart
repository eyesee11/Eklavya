import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.waving_hand, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Onboarding Page'),
            SizedBox(height: 8),
            Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
