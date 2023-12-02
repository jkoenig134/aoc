import 'dart:io';

import 'input_reader.dart';

Future<void> runSolutions<T>(
  T Function(InputReader) parse,
  dynamic Function(T) part1Fn,
  dynamic Function(T) part2Fn, {
  String splitPattern = '\n',
}) async {
  final day = _dayFromProcessArgv();
  final year = _yearFromProcessArgv();

  final inputReader = InputReader(day, year, splitPattern);
  await inputReader.init();

  final input = parse(inputReader);
  print('''Real
  (1) ${part1Fn(input)}
  (2) ${part2Fn(input)}
  ''');
}

int _dayFromProcessArgv() {
  final dayArgument = Platform.script.pathSegments.last;
  return int.parse(dayArgument.substring(3, 5));
}

int _yearFromProcessArgv() {
  final yearArgument = Platform.script.pathSegments[Platform.script.pathSegments.length - 2];
  return int.parse(yearArgument);
}
