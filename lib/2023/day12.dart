import 'package:collection/collection.dart';

import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

int part1(List<String> input) => input.map(allArrangements).sum;

int part2(List<String> input) => input.map(expand).map(allArrangements).sum;

String expand(String input) {
  final split = input.split(' ');
  final field = '${split[0]}?' * 5;
  final pattern = '${split[1]},' * 5;

  return '${field.substring(0, field.length - 1)} ${pattern.substring(0, pattern.length - 1)}';
}

int allArrangements(String line) {
  final [springs, config] = line.split(' ');
  final conditions = config.split(',').map(int.parse).toList();
  final split = springs.split('').map(
        (e) => switch (e) {
          '.' => (false, false),
          '#' => (true, true),
          '?' => (true, false),
          final _ => throw Exception('invalid $e'),
        },
      );
  var springArrangements = [(group: 0, amount: 0, arrangements: 1)];
  final springArrangementCounts = {(group: 0, amount: 0): 1};

  for (final spring in split) {
    if (spring.$1 == spring.$2) {
      springArrangements = springArrangementCounts.entries
          .map((e) => (group: e.key.group, amount: e.key.amount, arrangements: e.value))
          .map(
            (e) => [
              if (spring.$1 && e.group < conditions.length && e.amount < conditions[e.group])
                (group: e.group, amount: e.amount + 1, arrangements: e.arrangements)
              else if (!spring.$1 && e.amount == 0)
                e
              else if (!spring.$1 && e.amount == conditions[e.group])
                (group: e.group + 1, amount: 0, arrangements: e.arrangements),
            ],
          )
          .flattened
          .toList();
    } else {
      springArrangements = springArrangementCounts.entries
          .map(
            (e) => (group: e.key.group, amount: e.key.amount, arrangements: e.value),
          )
          .map(
            (e) => [
              if (e.group < conditions.length && e.amount < conditions[e.group]) (group: e.group, amount: e.amount + 1, arrangements: e.arrangements),
              if (e.amount == 0) e else if (e.amount == conditions[e.group]) (group: e.group + 1, amount: 0, arrangements: e.arrangements),
            ],
          )
          .flattened
          .toList();
    }
    springArrangementCounts.clear();
    for (final springPermutation in springArrangements) {
      springArrangementCounts.update(
        (group: springPermutation.group, amount: springPermutation.amount),
        (value) => value + springPermutation.arrangements,
        ifAbsent: () => springPermutation.arrangements,
      );
    }
  }

  springArrangements = springArrangements
      .where(
        (element) =>
            (element.group == conditions.length - 1 && element.amount == conditions.last) ||
            (element.group == conditions.length && element.amount == 0),
      )
      .toList();

  return springArrangements.map((e) => e.arrangements).sum;
}
