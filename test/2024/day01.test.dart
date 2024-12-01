import 'package:aoc/2024/day01.dart';
import 'package:test/test.dart';

void main() {
  final input = parse([
    '3   4',
    '4   3',
    '2   5',
    '1   3',
    '3   9',
    '3   3',
  ]);

  test('part 1', () {
    expect(part1(input), 11);
  });

  test('part 2', () {
    expect(part2(input), 31);
  });
}
