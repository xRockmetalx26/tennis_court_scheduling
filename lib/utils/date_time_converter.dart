class DateTimeConverter {
  static DateTime toYMD(DateTime dateTime) {
    final dateTimeFormatted =
        DateTime(dateTime.year, dateTime.month, dateTime.day);

    return dateTimeFormatted;
  }

  static String toYMDString(DateTime dateTime) =>
      dateTime.toString().substring(0, 10);
}
