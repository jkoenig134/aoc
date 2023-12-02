import 'dart:math';

import '/utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) => i.asInt(),
      part1,
      part2,
      splitPattern: ',',
    );

int calculateMinimalCost(List<int> input, int Function(int) costFunction) {
  Map<int, int> costForSteps = {};

  final results = Set<int>.from(input).map(
    (n) => input.map((e) => (n - e).abs()).map((e) => costForSteps.putIfAbsent(e, () => costFunction(e))).sum,
  );

  return results.reduce(min);
}

int part1(List<int> input) => calculateMinimalCost(input, (e) => e);

int part2(List<int> input) => calculateMinimalCost(input, (e) => e * (e + 1) ~/ 2);
