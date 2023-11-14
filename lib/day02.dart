import 'utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) => i.asString(),
      part1,
      part2,
    );

int part1(List<String> input) => input.map(calculateP1).sum;

int calculateP1(String input) {
  final split = input.split("x");

  final l = int.parse(split[0]);
  final w = int.parse(split[1]);
  final h = int.parse(split[2]);

  final sides = [l * w, w * h, h * l];
  return sides.map((e) => e * 2).sum + sides.min;
}

int part2(List<String> input) => input.map(calculateP2).sum;

int calculateP2(String input) {
  final split = input.split("x");

  final l = int.parse(split[0]);
  final w = int.parse(split[1]);
  final h = int.parse(split[2]);

  final sides = [l, w, h];
  sides.remove(sides.max);

  final first = sides[0] + sides[0] + sides[1] + sides[1];
  final second = l * w * h;

  return first + second;
}
