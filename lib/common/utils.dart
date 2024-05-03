List<String> splitString(String input) {
  List<String> substrings = [];
  for (int i = 0; i < input.length; i += 50) {
    substrings
        .add(input.substring(i, i + 50 < input.length ? i + 50 : input.length));
  }
  return substrings;
}
