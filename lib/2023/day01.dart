import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

int part1(List<String> input) => input.map(getCalibration).sum;

int getCalibration(String input) {
  final digits = RegExp(r'\d').allMatches(input).map((e) => e.group(0)!);
  final resultingNumber = '${digits.first}${digits.last}';

  return int.parse(resultingNumber);
}

int part2(List<String> input) => input.map(getCalibrationWithLetters).sum;

int getCalibrationWithLetters(String input) {
  final writtenNumbers = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];

  // matching numbers or written numbers in the group on position 1 (lookahead for also matching overlapping written numbers)
  final regex = RegExp('(?=(\\d|${writtenNumbers.join("|")}))');
  final digits = regex //
      .allMatches(input)
      .map((e) => e.group(1)!)
      .map((e) => !writtenNumbers.contains(e) ? e : writtenNumbers.indexOf(e).toString())
      .toList();

  final resultingNumber = '${digits.first}${digits.last}';

  return int.parse(resultingNumber);
}
