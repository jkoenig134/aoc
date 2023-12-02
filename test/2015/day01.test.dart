import 'package:aoc/2015/day01.dart';
import 'package:test/test.dart';

void main() {
  test('part 1', () {
    expect(part1('(())'), 0);
    expect(part1('()()'), 0);

    expect(part1('((('), 3);
    expect(part1('(()(()('), 3);

    expect(part1('))((((('), 3);

    expect(part1('())'), -1);
    expect(part1('))('), -1);

    expect(part1(')))'), -3);
    expect(part1(')())())'), -3);
  });

  test('part 2', () {
    expect(part2(')'), 1);
    expect(part2('()())'), 5);
  });
}
