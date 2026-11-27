import 'package:flutter/material.dart';

import 'check_in_screen.dart';
import 'daily_check_in.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DailyCheckIn? _latestCheckIn;

  Future<void> _openCheckIn() async {
    final result = await Navigator.of(context).push<DailyCheckIn>(
      MaterialPageRoute(
        builder: (context) => const CheckInScreen(),
      ),
    );

    if (!mounted || result == null) return;

    setState(() {
      _latestCheckIn = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Good morning',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text('Notice your wellbeing patterns one day at a time.'),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's check-in",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('Record a few details about your day.'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _openCheckIn,
                    icon: const Icon(Icons.edit_note),
                    label: Text(
                      _latestCheckIn == null
                          ? 'Start check-in'
                          : 'Update check-in',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Today at a glance',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.bedtime_outlined),
                  title: const Text('Sleep'),
                  subtitle: Text(
                    _latestCheckIn?.sleepSummary ?? 'Not logged yet',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.directions_walk_outlined),
                  title: const Text('Physical activity'),
                  subtitle: Text(
                    _latestCheckIn == null
                        ? 'Not logged yet'
                        : '${_latestCheckIn!.activityMinutes} minutes',
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restaurant_outlined),
                  title: const Text('Meals'),
                  subtitle: Text(
                    _latestCheckIn?.mealsSummary ?? 'Not logged yet',
                  ),
                ),
              ],
            ),
          ),
          if (_latestCheckIn != null) ...[
            const SizedBox(height: 12),
            Text(
              'Saved ${_latestCheckIn!.recordedAt.toLocal()}',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
            ),
          ],
        ],
      ),
    );
  }
}
