import 'package:aoc/2015/day08.dart';
import 'package:test/test.dart';

void main() {
  final testInput = [
    '""',
    '"abc"',
    '"aaa\\"aaa"',
    '"\\x27"',
  ];

  test('part 1', () {
    expect(part1(testInput), 12);
  });

  test('part 2', () {
    expect(part2(testInput), 19);
  });
}
