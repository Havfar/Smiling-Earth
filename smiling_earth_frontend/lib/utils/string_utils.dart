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
