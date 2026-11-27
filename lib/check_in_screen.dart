import 'package:flutter/material.dart';

import 'daily_check_in.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sleepHoursController = TextEditingController();
  final _activityMinutesController = TextEditingController();
  bool _enterExactHours = false;
  String? _sleepRange;
  int? _mealsToday;

  @override
  void dispose() {
    _sleepHoursController.dispose();
    _activityMinutesController.dispose();
    super.dispose();
  }

  void _saveCheckIn() {
    if (!_formKey.currentState!.validate()) return;

    final checkIn = DailyCheckIn(
      sleepHours: _enterExactHours
          ? double.parse(_sleepHoursController.text.trim())
          : null,
      sleepRange: _enterExactHours ? null : _sleepRange,
      activityMinutes: int.parse(_activityMinutesController.text.trim()),
      mealsToday: _mealsToday!,
      recordedAt: DateTime.now(),
    );

    Navigator.of(context).pop(checkIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily check-in')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Your daily check-in',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            const Text('Your answers stay on this device for this demo.'),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sleep last night',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(
                          value: false,
                          label: Text('Choose a range'),
                        ),
                        ButtonSegment(
                          value: true,
                          label: Text('Enter hours'),
                        ),
                      ],
                      selected: {_enterExactHours},
                      onSelectionChanged: (selection) {
                        setState(() {
                          _enterExactHours = selection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    if (_enterExactHours)
                      TextFormField(
                        controller: _sleepHoursController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Hours slept',
                          suffixText: 'hours',
                        ),
                        validator: (value) {
                          final hours = double.tryParse(value?.trim() ?? '');
                          if (hours == null || hours < 0 || hours > 24) {
                            return 'Enter a number from 0 to 24';
                          }
                          return null;
                        },
                      )
                    else
                      DropdownButtonFormField<String>(
                        initialValue: _sleepRange,
                        decoration: const InputDecoration(
                          labelText: 'Hours slept',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'under6',
                            child: Text('Under 6 hours'),
                          ),
                          DropdownMenuItem(
                            value: '6to8',
                            child: Text('6-8 hours'),
                          ),
                          DropdownMenuItem(
                            value: 'over8',
                            child: Text('Over 8 hours'),
                          ),
                        ],
                        validator: (value) => value == null
                            ? 'Choose a sleep range'
                            : null,
                        onChanged: (value) {
                          setState(() {
                            _sleepRange = value;
                          });
                        },
                      ),
                    const SizedBox(height: 24),
                    Text(
                      'Physical activity today',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _activityMinutesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Activity duration',
                        suffixText: 'minutes',
                      ),
                      validator: (value) {
                        final minutes = int.tryParse(value?.trim() ?? '');
                        if (minutes == null || minutes < 0 || minutes > 1440) {
                          return 'Enter a whole number from 0 to 1440';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'How many meals have you had today?',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      initialValue: _mealsToday,
                      decoration: const InputDecoration(
                        labelText: 'Meals today',
                      ),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text('0 meals')),
                        DropdownMenuItem(value: 1, child: Text('1 meal')),
                        DropdownMenuItem(value: 2, child: Text('2 meals')),
                        DropdownMenuItem(value: 3, child: Text('3 meals')),
                        DropdownMenuItem(
                          value: 4,
                          child: Text('4 or more meals'),
                        ),
                      ],
                      validator: (value) => value == null
                          ? 'Choose how many meals'
                          : null,
                      onChanged: (value) {
                        setState(() {
                          _mealsToday = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 54,
                      child: FilledButton.icon(
                        onPressed: _saveCheckIn,
                        icon: const Icon(Icons.save_outlined),
                        label: const Text('Save check-in'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}