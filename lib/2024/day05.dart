import '/utils/utils.dart';

typedef Input = ({List<List<int>> orderingRules, List<List<int>> updates});

main(List<String> args) => runSolutions((i) => parse(i.raw()), part1, part2);

int part1(Input input) => input.updates.where((e) => isCorrectlyOrdered(e, input.orderingRules)).map((e) => e.middleElement).sum;

int part2(Input input) => input.updates
    .where((e) => !isCorrectlyOrdered(e, input.orderingRules))
    .map((e) => orderBasedOnOrderingRules(e, input.orderingRules))
    .map((e) => e.middleElement)
    .sum;

Input parse(String input) {
  final split = input.split('\n\n');

  return (
    orderingRules: split[0].split('\n').map((e) => e.split('|').map(int.parse).toList()).toList(),
    updates: split[1].split('\n').map((e) => e.split(',').map(int.parse).toList()).toList(),
  );
}

bool isCorrectlyOrdered(List<int> update, List<List<int>> orderingRules) {
  for (var i = 0; i < update.length - 1; i++) {
    if (!orderingRules.any((rule) => rule[0] == update[i] && rule[1] == update[i + 1])) {
      return false;
    }
  }

  return true;
}

List<int> orderBasedOnOrderingRules(List<int> update, List<List<int>> orderingRules) {
  final newUpdate = List.of(update);

  for (var i = 0; i < newUpdate.length - 1; i++) {
    if (!orderingRules.any((rule) => rule[0] == newUpdate[i] && rule[1] == newUpdate[i + 1])) {
      final temp = newUpdate[i];
      newUpdate[i] = newUpdate[i + 1];
      newUpdate[i + 1] = temp;
    }
  }

  if (!isCorrectlyOrdered(newUpdate, orderingRules)) {
    return orderBasedOnOrderingRules(newUpdate, orderingRules);
  }

  return newUpdate;
}
