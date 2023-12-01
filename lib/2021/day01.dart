import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asInt(), part1, part2);

int part1(List<int> input) =>
    input.windowed(2).where((w) => w[1] > w[0]).length;

int part2(List<int> input) {
  final unnoised = input.windowed(3).map((w) => w.sum).toList();
  return part1(unnoised);
}
