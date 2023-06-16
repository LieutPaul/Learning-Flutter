List<DateTime> getWeekFromLastSunday() {
  DateTime today = DateTime.now();
  DateTime lastSunday = today.subtract(Duration(days: today.weekday));

  List<DateTime> week = [];
  for (int i = 0; i < 7; i++) {
    DateTime day = lastSunday.add(Duration(days: i));
    week.add(day);
  }

  return week;
}
