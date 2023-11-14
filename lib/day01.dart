import 'utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

int part1(String input) {
  return input.split("").fold(
        0,
        (previousValue, element) => switch (element) {
          '(' => previousValue + 1,
          ')' => previousValue - 1,
          _ => previousValue,
        },
      );
}

int part2(String input) {
  final instructions = input.split("").toList();

  var floor = 0;

  for (var i = 0; i < instructions.length; i++) {
    final instruction = instructions[i];
    floor = switch (instruction) {
      '(' => floor + 1,
      ')' => floor - 1,
      _ => floor,
    };

    if (floor == -1) return i + 1;
  }

  throw Exception("Santa never reaches the basement");
}
