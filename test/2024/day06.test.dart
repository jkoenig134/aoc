import 'package:aoc/2024/day06.dart';
import 'package:test/test.dart';

void main() {
  final input = '''....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...'''
      .split('\n')
      .map((e) => e.split(''))
      .toList();

  test('part 1', () {
    expect(part1(input), 41);
  });

  test('part 2', () {
    expect(part2(input), 0);
  });
}
