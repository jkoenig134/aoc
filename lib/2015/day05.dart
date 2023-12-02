import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

int part1(List<String> input) => input.where(isStringNiceP1).length;

bool isStringNiceP1(String input) {
  // It does not contain the strings ab, cd, pq, or xy, even if they are part of one of the other requirements.
  if (input.contains('ab') ||
      input.contains('cd') ||
      input.contains('pq') ||
      input.contains('xy')) {
    return false;
  }

  // It contains at least three vowels (aeiou only), like aei, xazegov, or aeiouaeiouaeiou.
  final vowels = RegExp(r'[aeiou].*[aeiou].*[aeiou]');
  if (!vowels.hasMatch(input)) return false;

  // It contains at least one letter that appears twice in a row, like xx, abcdde (dd), or aabbccdd (aa, bb, cc, or dd).
  final doubleLetter = RegExp(r'([a-z])\1');
  if (!doubleLetter.hasMatch(input)) return false;

  return true;
}

int part2(List<String> input) => input.where(isStringNiceP2).length;

bool isStringNiceP2(String input) {
  // It contains a pair of any two letters that appears at least twice in the string without overlapping, like xyxy (xy) or aabcdefgaa (aa), but not like aaa (aa, but it overlaps).
  final pair = RegExp(r'([a-z]{2}).*\1');
  if (!pair.hasMatch(input)) return false;

  // It contains at least one letter which repeats with exactly one letter between them, like xyx, abcdefeghi (efe), or even aaa.
  final repeat = RegExp(r'([a-z]).\1');
  if (!repeat.hasMatch(input)) return false;

  return true;
}
