class DailyCheckIn {
  const DailyCheckIn({
    required this.sleepHours,
    required this.sleepRange,
    required this.activityMinutes,
    required this.mealsToday,
    required this.recordedAt,
  });

  final double? sleepHours;
  final String? sleepRange;
  final int activityMinutes;
  final int mealsToday;
  final DateTime recordedAt;

  String get sleepSummary {
    if (sleepHours != null) return '$sleepHours hours';

    return switch (sleepRange) {
      'under6' => 'Under 6 hours',
      '6to8' => '6-8 hours',
      'over8' => 'Over 8 hours',
      _ => 'Not recorded',
    };
  }

  String get mealsSummary => mealsToday == 4
      ? '4 or more meals'
      : '$mealsToday ${mealsToday == 1 ? 'meal' : 'meals'}';
}