import 'package:flutter/material.dart';

class TestSelectionPage extends StatelessWidget {
  const TestSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Test Selection Page'),
            SizedBox(height: 8),
            Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
