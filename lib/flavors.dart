enum Flavor {
  dev,
  qa,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return '[DEV] Aegislabs';
      case Flavor.qa:
        return '[QA] Aegislabs';
      case Flavor.prod:
        return 'Aegislabs';
      default:
        return 'title';
    }
  }

}
