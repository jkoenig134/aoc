import 'package:aoc/2023/day10.dart';
import 'package:aoc/utils/utils.dart';
import 'package:test/test.dart';

void main() {
  final testInput1 = '''.....
.S-7.
.|.|.
.L-J.
.....''';

  final testInput2 = '''-L|F7
7S-7|
L|7||
-L-J|
L|-JF''';

  final testInput3 = '''..F7.
.FJ|.
SJ.L7
|F--J
LJ...''';

  final ps1 = testInput1.toPipeSystem();
  final ps2 = testInput2.toPipeSystem();
  final ps3 = testInput3.toPipeSystem();

  test('part 1', () => expect(part1(ps1), 4));
  test('part 1', () => expect(part1(ps2), 4));
  test('part 1', () => expect(part1(ps3), 8));

  final part2Input = '''...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
...........''';

  test('part 2', () => expect(part2(part2Input.toPipeSystem()), 4));

  final part2Large = '''.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ...''';

  test('part 2', () => expect(part2(part2Large.toPipeSystem()), 8));

  test('diagonal', () {
    final input = [
      [1, 2, 3],
      [4, 5, 6],
    ];

    expect(input.diagonal(), [
      [1],
      [4, 2],
      [5, 3],
      [6],
    ]);
  });
}
