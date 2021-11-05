import 'dart:math';

String truncate(
  String text,
  int length,
) {
  String omission = '...';
  if (length >= text.length) {
    return text;
  }
  return text.replaceRange(length, text.length, omission);
}

double roundOffToXDecimal(double number, {int numberOfDecimal = 3}) {
  String numbersAfterDecimal = number.toString().split('.')[1];
  if (numbersAfterDecimal != '0') {
    int existingNumberOfDecimal = numbersAfterDecimal.length;
    number += 1 / (10 * pow(10, existingNumberOfDecimal));
  }

  return double.parse(number.toStringAsFixed(numberOfDecimal));
}
