import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

int part1(List<String> input) {
  final codeLength = input.map((e) => e.length).sum;

  final unescaped = input
      .map(
        (e) => e.substring(1, e.length - 1).replaceAll(RegExp(r'\\(\\|"|x[0-9a-f]{2})'), "'"),
      )
      .toList();

  final unescapedLength = unescaped.map((e) => e.length).sum;
  return codeLength - unescapedLength;
}

int part2(List<String> input) {
  final codeLength = input.map((e) => e.length).sum;

  final escaped = input.map((e) => e.replaceAll('\\', '\\\\').replaceAll('"', '\\"')).toList();

  final escapedLength = escaped.map((e) => e.length + 2).sum;
  return escapedLength - codeLength;
}
