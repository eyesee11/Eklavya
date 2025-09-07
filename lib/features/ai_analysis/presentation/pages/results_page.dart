import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assessment, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('Results Page'),
            SizedBox(height: 8),
            Text('Coming Soon...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
