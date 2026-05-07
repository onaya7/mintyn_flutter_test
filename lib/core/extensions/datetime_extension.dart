extension DateTimeExtension on DateTime {
  /// Converts DateTime to time string in 12-hour format (e.g., "12:10 pm")
  String toTimeString() {
    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? 'pm' : 'am';
    return '$hour:$minute $period';
  }

  /// Converts DateTime to date string in MM-dd-yyyy format (e.g., "12-12-2024")
  String toDateString() {
    final month = this.month.toString().padLeft(2, '0');
    final day = this.day.toString().padLeft(2, '0');
    return '$month-$day-$year';
  }

  /// Combines date and time strings
  String toDateTimeString() {
    return '${toDateString()} ${toTimeString()}';
  }
}
