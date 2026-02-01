extension DateTimeExtension on DateTime {
  String get convertToTextDisplay {
    final current = DateTime.now();
    final String hourTime =
        "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";

    String dateString =
        '${day.toString().padLeft(2, '0')}/'
        '${month.toString().padLeft(2, '0')}/'
        '$year';
    if (isToday(current)) {
      dateString = 'Today At:';
    } else if (isTomorow(current)) {
      dateString = 'Tomorow At:';
    }
    return "$dateString $hourTime";
  }

  bool isTomorow(DateTime other) {
    final tomorow = DateTime(other.year, other.month, other.day + 1);
    if (year == tomorow.year && tomorow.month == month && tomorow.day == day) {
      return true;
    }
    return false;
  }

  bool isToday(DateTime other) {
    if (year == other.year && other.month == month && other.day == day) {
      return true;
    }
    return false;
  }
}
