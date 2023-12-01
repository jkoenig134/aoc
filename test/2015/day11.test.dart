import 'package:aoc/2015/day11.dart';
import 'package:test/test.dart';

void main() {
  test("passwords match", () {
    expect(isPasswordValid("hijklmmn"), false);
    expect(isPasswordValid("abbceffg"), false);
    expect(isPasswordValid("abbcegjk"), false);
    expect(isPasswordValid("abcdefgh"), false);
    expect(isPasswordValid("abcdffaa"), true);
    expect(isPasswordValid("ghijklmn"), false);
    expect(isPasswordValid("ghjaabcc"), true);
  });

  test("increase passwords", () {
    expect(increasePassword("abcdefgh"), "abcdffaa");
    expect(increasePassword("ghijklmn"), "ghjaabcc");
  });
}
