import 'package:aoc/2024/day04.dart';
import 'package:test/test.dart';

void main() {
  final input = '''MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX'''
      .split('\n')
      .map((e) => e.split(''))
      .toList();

  test('part 1', () {
    expect(part1(input), 18);
  });

  test('part 2', () {
    expect(part2(input), 9);
  });
}
