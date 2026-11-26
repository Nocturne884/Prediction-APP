import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Dashboard')),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Good morning', style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: 8),
        const Text('A quick cjeck-in can help you notice your wellbeing patterns.'),
        const SizedBox(height:24),
       Card(
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Today's Check-In"),
        const SizedBox(height: 8),
        Text(
          'How have you been feeling?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
          const SizedBox(height: 16),
          FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar
            (
              const SnackBar(
                content: Text('Check-in questions are next.'),
              ),
            );
                        },
          icon: const Icon(Icons.edit_note),
          label: const Text('Start check-in'),
        ),
      ],
    ),
  ),
       ), // closes Card
      ],   // closes ListView's children list
    ),     // closes ListView
    );     // closes Scaffold
  }        // closes build()
}          // closes DashboardScreen
