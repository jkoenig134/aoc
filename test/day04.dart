import 'package:aoc2015/day04.dart';
import 'package:test/test.dart';

void main() {
  test('part 1', () {
    expect(part1("abcdef"), 609043);
    expect(part1("pqrstuv"), 1048970);
  });

  test('part 2', () {
    expect(part2("abcdef"), 6742839);
    expect(part2("pqrstuv"), 5714438);
  });
}
