
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
const Map<int, String> daysSuffix = {
  1: "st",
  2: "nd",
  3: "rd",
  4: "th",
  5: "th",
  6: "th",
  7: "th",
  8: "th",
  9: "th",
  10: "th",
  11: "th",
  12: "th",
};

String formattedDate(DateTime? date){
  return '${date!.day}${daysSuffix[date.day%10]} ${monthsInYear[date.month]},  ${date.year}';
}

