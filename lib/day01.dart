import 'utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

int part1(String input) => input.split("").fold(0, (prev, e) => move(prev, e));

int part2(String input) {
  var floor = 0;

  for (final x in input.split("").indexed) {
    floor = move(floor, x.$2);
    if (floor == -1) return x.$1 + 1;
  }

  throw Exception("Santa never reaches the basement");
}

int move(int floor, String instruction) => switch (instruction) {
      '(' => ++floor,
      ')' => --floor,
      _ => floor,
    };
