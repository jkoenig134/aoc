import '/utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) => i.asString(),
      part1,
      part2,
    );

int part1(List<String> input) =>
    input.map((e) => [e.substring(0, e.length ~/ 2), e.substring(e.length ~/ 2)]).map(findSameChar).map(charToNumber).reduce((a, b) => a + b);

int part2(List<String> input) => input.windowedExclusive(3).map(findSameChar).map(charToNumber).reduce((a, b) => a + b);

String findSameChar(List<String> strings) {
  for (String char in strings[0].split('')) {
    if (strings.every((element) => element.contains(char))) return char;
  }

  throw Exception('No same char found');
}

int charToNumber(String c) {
  final code = c.codeUnitAt(0);
  if (code >= 65 && code <= 90) return code - 38;
  if (code >= 97 && code <= 122) return code - 96;
  throw Exception('Unknown char: $c');
}
