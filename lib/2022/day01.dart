import '/utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) =>
          i.asIntList(firstSplit: '\n\n', secondSplit: '\n').mapL((e) => e.sum)
            ..sort((a, b) => b - a),
      part1,
      part2,
    );

int part1(List<int> input) => input[0];
int part2(List<int> input) => input.take(3).sum;
