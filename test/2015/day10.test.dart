import 'package:aoc/2015/day10.dart';
import 'package:test/test.dart';

void main() {
  test("look and say once", () {
    expect(lookAndSay("1111112223333333"), "613273");
  });

  test('look and say x times', () {
    expect(lookAndSayXTimes("1", 5), "312211");
    expect(lookAndSayXTimes("1", 10), "11131221133112132113212221");
  });
}
