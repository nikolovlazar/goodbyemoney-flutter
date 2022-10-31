enum Period {
  day,
  week,
  month,
  year,
}

String getPeriodName(Period period) {
  switch (period) {
    case Period.day:
      return "Day";
    case Period.week:
      return "Week";
    case Period.month:
      return "Month";
    case Period.year:
      return "Year";
  }
}

String getPeriodDisplayName(Period period) {
  switch (period) {
    case Period.day:
      return "Today";
    case Period.week:
      return "This week";
    case Period.month:
      return "This month";
    case Period.year:
      return "This year";
  }
}

List<Period> periods = [Period.day, Period.week, Period.month, Period.year];
