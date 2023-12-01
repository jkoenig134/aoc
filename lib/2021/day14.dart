import 'dart:math';

import '/utils/utils.dart';

class Polymerization {
  late Map<String, String> _rules;
  Map<String, int> _tupleCount = {};

  late String _lastChar;

  Polymerization(String input) {
    final split = input.split("\n\n");

    _rules = {
      for (final line in split[1].split("\n"))
        line.substring(0, 2): line.substring(6)
    };

    final formula = split[0];
    formula
        .split("")
        .windowed(2)
        .map((e) => e.join())
        .forEach((e) => _tupleCount[e] = (_tupleCount[e] ?? 0) + 1);
    _lastChar = formula[formula.length - 1];
  }

  Polymerization polymerizeFor(int count) {
    for (var i = 0; i < count; i++) {
      polymerize();
    }

    return this;
  }

  void polymerize() {
    final Map<String, int> newCount = {};

    for (String k in _tupleCount.keys) {
      final insertion = _rules[k]!;

      final firstHalf = k[0] + insertion;
      final secondHalf = insertion + k[1];

      newCount[firstHalf] = (newCount[firstHalf] ?? 0) + _tupleCount[k]!;
      newCount[secondHalf] = (newCount[secondHalf] ?? 0) + _tupleCount[k]!;
    }

    _tupleCount = newCount;
  }

  int calculate() {
    final Map<String, int> charCount = {};

    for (String k in _tupleCount.keys) {
      charCount[k[0]] = charCount.putIfAbsent(k[0], () => 0) + _tupleCount[k]!;
    }

    charCount[_lastChar] = charCount[_lastChar]! + 1;

    return charCount.values.reduce(max) - charCount.values.reduce(min);
  }
}

main(List<String> args) =>
    runSolutions((i) => Polymerization(i.raw()), part1, part2);

int part1(Polymerization input) => input.polymerizeFor(10).calculate();

int part2(Polymerization input) => input.polymerizeFor(30).calculate();
