import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => parse(i.asString()), part1, part2);

(List<int>, List<int>) parse(List<String> input) {
  final tuples = input.map((e) => e.split('   ').map(int.parse).toList()).toList();
  return (tuples.map((e) => e[0]).toList()..sort(), tuples.map((e) => e[1]).toList()..sort());
}

int part1((List<int>, List<int>) input) => input.$1.mapIndexed((e, index) => (e - input.$2[index]).abs()).sum;

int part2((List<int>, List<int>) input) => input.$1.mapIndexed((e, index) => (e * input.$2.where((sE) => sE == e).length).abs()).sum;
