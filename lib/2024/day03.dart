import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString().join(''), part1, part2);

int part1(String input) => RegExp(r'mul\((\d+),(\d+)\)').allMatches(input).map((e) => int.parse(e.group(1)!) * int.parse(e.group(2)!)).sum;

int part2(String input) {
  final mulDoDontRegex = RegExp(r"(mul\((\d+),(\d+)\))|(do\(\))|(don't\(\))");

  bool mulEnabled = true;
  var result = 0;

  for (final match in mulDoDontRegex.allMatches(input)) {
    if (match.group(1) != null) {
      if (mulEnabled) {
        result += int.parse(match.group(2)!) * int.parse(match.group(3)!);
      }
    } else if (match.group(4) != null) {
      mulEnabled = true;
    } else if (match.group(5) != null) {
      mulEnabled = false;
    }
  }

  return result;
}
