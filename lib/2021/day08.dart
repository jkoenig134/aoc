import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

int part1(List<String> input) {
  return input
      .map((e) => e
          .split(' | ')[1]
          .split(' ')
          .map((e) => e.length)
          .where((e) => e == 2 || e == 3 || e == 4 || e == 7)
          .length)
      .sum;
}

class DigitProcessor {
  final List<String> input;
  final List<String> output;

  DigitProcessor(String inputRow, outputRow)
      : input = inputRow.split(' '),
        output = outputRow.split(' ');

  final Map<String, int> _inputMap = {};
  void _enter(String input, int number) {
    final split = input.split("")..sort();
    _inputMap[split.join()] = number;
  }

  String _receive(String input) {
    final split = input.split("")..sort();
    return _inputMap[split.join()]?.toString() ?? "NaN";
  }

  int calculate() {
    final one = input.where((e) => e.length == 2).first;
    _enter(one, 1);

    final seven = input.where(((e) => e.length == 3)).first;
    _enter(seven, 7);

    final four = input.where((e) => e.length == 4).first;
    _enter(four, 4);

    _enter(input.where((e) => e.length == 7).first, 8);

    final nine = input
        .where((e) => e.length == 6)
        .where((e) => e.split("").toSet().containsAll(four.split('')))
        .first;
    _enter(nine, 9);

    final zero = input
        .where((e) => e.length == 6 && e != nine)
        .where((e) => e.split("").toSet().containsAll(one.split('')))
        .first;
    _enter(zero, 0);

    final six =
        input.where((e) => e.length == 6 && e != nine && e != zero).first;
    _enter(six, 6);

    final three = input
        .where((e) => e.length == 5)
        .where((e) => e.split("").toSet().containsAll(seven.split('')))
        .first;
    _enter(three, 3);

    final five = input
        .where((element) => element.length == 5 && element != three)
        .where(
          (e) => e.split("").where((e) => !nine.split("").contains(e)).isEmpty,
        )
        .first;
    _enter(five, 5);

    _enter(
      input.where((e) => e.length == 5 && e != three && e != five).first,
      2,
    );

    return int.parse(output.map((e) => _receive(e)).join());
  }
}

int part2(List<String> input) {
  return input
      .map((e) => e.split(' | '))
      .map((e) => DigitProcessor(e[0], e[1]).calculate())
      .sum;
}
