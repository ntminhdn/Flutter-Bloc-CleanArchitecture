extension StringExtensions on String {
  String plus(String other) {
    return this + other;
  }

  bool equalsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());
}
