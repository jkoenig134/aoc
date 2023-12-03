import 'package:aoc/2023/day03.dart';
import 'package:test/test.dart';

void main() {
  final testInput = '''467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...\$.*....
.664.598..''';

  final testEngine = EngineSchematic.fromString(testInput);

  test('part 1', () => expect(part1(testEngine), 4361));

  test('part 2', () => expect(part2(testEngine), 467835));
}
