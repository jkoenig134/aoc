import 'package:aoc/2015/day02.dart';
import 'package:test/test.dart';

void main() {
  test('part 1', () {
    expect(calculateP1('2x3x4'), 58);
    expect(calculateP1('1x1x10'), 43);
  });

  test('part 2', () {
    expect(calculateP2('2x3x4'), 34);
    expect(calculateP2('1x1x10'), 14);
  });
}
