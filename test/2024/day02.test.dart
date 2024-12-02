import 'package:aoc/2024/day02.dart';
import 'package:test/test.dart';

void main() {
  final input = [
    '7 6 4 2 1',
    '1 2 7 8 9',
    '9 7 6 2 1',
    '1 3 2 4 5',
    '8 6 4 4 1',
    '1 3 6 7 9',
  ].map((e) => e.split(' ').map(int.parse).toList()).toList();

  test('part 1', () {
    expect(part1(input), 2);
  });

  test('part 2', () {
    expect(part2(input), 4);
  });
}
