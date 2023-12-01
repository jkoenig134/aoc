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
  final allMatches =
      RegExp(r'(?=(\d|one|two|three|four|five|six|seven|eight|nine))')
          .allMatches(input)
          .toList();
  final digits = allMatches.map((e) => e.group(1)!).map(
        (e) => switch (e) {
          'one' => '1',
          'two' => '2',
          'three' => '3',
          'four' => '4',
          'five' => '5',
          'six' => '6',
          'seven' => '7',
          'eight' => '8',
          'nine' => '9',
          _ => e,
        },
      );

  final resultingNumber = '${digits.first}${digits.last}';

  return int.parse(resultingNumber);
}
