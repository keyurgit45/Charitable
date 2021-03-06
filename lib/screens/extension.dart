extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .split(" ")
      .map((str) => '${str[0].toUpperCase()}${str.substring(1)}')
      .join(" ");
}

main() {
  final helloWorld = 'hello world'.inCaps; // 'Hello world'
  final helloWorld1 = 'hello world'.allInCaps; // 'HELLO WORLD'
  final helloWorld2 = 'hello world'.capitalizeFirstofEach; // 'Hello World'
  print(helloWorld);
  print(helloWorld1);
  print(helloWorld2);
}
