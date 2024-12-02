import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asIntList(secondSplit: ' '), part1, part2);

bool isSafe(List<int> report) {
  final changes = report.windowed(2).map((e) => e[0] - e[1]);
  return changes.every((c) => c > 0 && c <= 3) || changes.every((c) => c < 0 && c >= -3);
}

int part1(List<List<int>> input) => input.where(isSafe).length;

bool isSafeDamped(List<int> report) {
  if (isSafe(report)) return true;

  if (isSafe(report.sublist(0, report.length - 1))) return true;

  for (var i = 1; i < report.length - 1; i++) {
    if (isSafe([...report.sublist(0, i), ...report.sublist(i + 1)])) return true;
  }

  if (isSafe(report.sublist(1, report.length))) return true;

  return false;
}

int part2(List<List<int>> input) => input.where(isSafeDamped).length;
