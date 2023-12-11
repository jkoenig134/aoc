import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asIntList(secondSplit: ' '), part1, part2);

int part1(List<List<int>> input) => input.map(history).sum;

int history(List<int> input) {
  final lists = <List<int>>[input];

  while (!lists.last.every((e) => e == 0)) {
    lists.add(lists.last.windowed(2).map((e) => e.last - e.first).toList());
  }

  return lists.map((e) => e.last).sum;
}

int part2(List<List<int>> input) => input.map(historyBackwards).sum;

int historyBackwards(List<int> input) {
  final lists = <List<int>>[input];

  while (!lists.last.every((e) => e == 0)) {
    lists.add(lists.last.windowed(2).map((e) => e.last - e.first).toList());
  }

  var current = lists.reversed.skip(1).first.first;
  for (final bla in lists.reversed.skip(2)) {
    current = bla.first - current;
  }

  return current;
}
