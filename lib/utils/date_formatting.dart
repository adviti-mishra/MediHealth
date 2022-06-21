const Map<int, String> monthsInYear = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December"
};

const Map<int, String> indicesOfDays = {
  0: "Sunday",
  1: "Monday",
  2: "Tuesday",
  3: "Wednesday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday"
};

String formattedDate(DateTime? date) {
  return '${date!.day} ${monthsInYear[date.month]},  ${date.year}';
}

List<String> toListOfDays(List<bool> values) {
  List<String> answer = List.filled(7, " ");
  int j = 0;
  for (int i = 0; i < 7; i++) {
    if (values[i] == true) {
      answer[j] = indicesOfDays[i].toString();
      j++;
    }
  }
  return answer;
}
