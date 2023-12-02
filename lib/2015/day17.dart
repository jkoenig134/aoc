import 'package:trotter/trotter.dart';

import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asInt().map(Container.new).toList(), part1, part2);

class Container {
  final int size;
  Container(this.size);
}

int part1(List<Container> input) => fillEggnog(input, 150).length;

int part2(List<Container> input) => numberOfEggnogWithMinContainers(input, 150);

List<List<Container>> fillEggnog(List<Container> containers, int liters) {
  final compounds = Subsets(containers)().toList();

  return compounds.where((c) => c.map((cnt) => cnt.size).sum == liters).toList();
}

int numberOfEggnogWithMinContainers(List<Container> containers, int liters) {
  final possiblities = fillEggnog(containers, liters);

  final minContainers = possiblities.map((c) => c.length).min;
  return possiblities.where((c) => c.length == minContainers).length;
}
