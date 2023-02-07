enum FlavorsEnum { develop, qa, staging, production }

class Flavor {
  final FlavorsEnum flavorEnum;
  final String name;
  final String prefix;
  final String envPath;

  const Flavor(
      {required this.flavorEnum,
        required this.name,
        required this.prefix,
        required this.envPath});

  bool isEqualToString(String value) {
    final String formattedValue = value.toLowerCase().trim();
    return formattedValue.contains(name.toLowerCase().trim()) ||
        formattedValue.contains(prefix.toLowerCase().trim());
  }
}
