import 'package:aoc/2023/day09.dart';
import 'package:test/test.dart';

void main() {
  final testInput = '''0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45''';

  final intLists = testInput.split('\n').map((e) => e.split(' ').map(int.parse).toList()).toList();

  test('part 1', () => expect(part1(intLists), 114));
  test('part 2', () => expect(part2(intLists), 2));
}
