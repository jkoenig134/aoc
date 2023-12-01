import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

int part1(String input) => lookAndSayXTimes(input, 40).length;

int part2(String input) => lookAndSayXTimes(input, 50).length;

String lookAndSayXTimes(String input, int times) {
  for (var i = 0; i < times; i++) {
    input = lookAndSay(input);
  }

  return input;
}

final _sameDigitRegex = RegExp(r'(\d)\1*');

String lookAndSay(String input) => input.replaceAllMapped(
      _sameDigitRegex,
      (match) => match.group(0)!.length.toString() + match.group(1)!,
    );
