import 'package:aoc/2015/day05.dart';
import 'package:test/test.dart';

void main() {
  group('part1', () {
    final tests = [
      ('ugknbfddgicrmopn', true),
      ('aaa', true),
      ('jchzalrnumimnmhp', false),
      ('haegwjzuvuyypxyu', false),
      ('dvszwmarrgswjxmb', false),
    ];

    tests.forEach((t) {
      test('isStringNiceP1(${t.$1}) returns ${t.$2}', () {
        expect(isStringNiceP1(t.$1), t.$2);
      });
    });
  });

  group('part2', () {
    final tests = [
      ('qjhvhtzxzqqjkmpb', true),
      ('xxyxx', true),
      ('uurcxstgmygtbstg', false),
      ('ieodomkazucvgmuy', false),
    ];

    tests.forEach((t) {
      test('isStringNiceP2(${t.$1}) returns ${t.$2}', () {
        expect(isStringNiceP2(t.$1), t.$2);
      });
    });
  });
}
