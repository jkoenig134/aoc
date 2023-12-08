import 'package:aoc/2023/day08.dart';
import 'package:test/test.dart';

void main() {
  final testInput1 = '''RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)''';

  final testInput2 = '''LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)''';

  final walker1 = Walker.fromString(testInput1);
  final walker2 = Walker.fromString(testInput2);

  test('stepsFromStartToEndsWith', () {
    expect(walker1.stepsFromStartToEndsWith(), 2);
    expect(walker2.stepsFromStartToEndsWith(), 6);
  });

  test('part 1', () => expect(part1(walker1), 2));

  final testInputPart2 = '''LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)''';

  final walkerPart2 = Walker.fromString(testInputPart2);

  test('part 2', () => expect(part2(walkerPart2), 6));
}
