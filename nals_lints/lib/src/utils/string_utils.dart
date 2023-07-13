extension StringExtensions on String {
  String plus(String other) {
    return this + other;
  }

  bool equalsIgnoreCase(String secondString) => toLowerCase().contains(secondString.toLowerCase());

  String replaceLast(Pattern pattern, String replacement) {
    final match = pattern.allMatches(this).lastOrNull;
    if (match == null) {
      return this;
    }
    final prefix = substring(0, match.start);
    final suffix = substring(match.end);
    return '$prefix$replacement$suffix';
  }
}
