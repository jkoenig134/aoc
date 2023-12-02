import 'package:aoc/2015/day03.dart';
import 'package:test/test.dart';

void main() {
  test('part 1', () {
    expect(part1('>'), 2);
    expect(part1('^>v<'), 4);
    expect(part1('^v^v^v^v^v'), 2);
  });

  test('part 2', () {
    expect(part2('^v'), 3);
    expect(part2('^v^v^v^v^v'), 11);
  });
}
