import '/utils/utils.dart';

class LowPoint {
  final int x;
  final int y;
  final int value;

  LowPoint(this.x, this.y, this.value);

  @override
  String toString() {
    return '$x - $y : $value}';
  }

  @override
  operator ==(other) {
    return other is LowPoint && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}

List<LowPoint> findLowPoints(List<List<int>> input) {
  final lowPoints = <LowPoint>[];

  for (var x = 0; x < input.length; x++) {
    for (var y = 0; y < input[x].length; y++) {
      final current = input[x][y];

      if ((x > 0 && input[x - 1][y] <= current) ||
          (x < input.length - 1 && input[x + 1][y] <= current) ||
          (y > 0 && input[x][y - 1] <= current) ||
          (y < input[x].length - 1 && input[x][y + 1] <= current)) {
        continue;
      }

      lowPoints.add(LowPoint(x, y, current));
    }
  }

  return lowPoints;
}

List<LowPoint> calculateBasinSize(List<List<int>> input, LowPoint lowPoint) {
  final basin = [lowPoint];

  final x = lowPoint.x;
  final y = lowPoint.y;
  final current = lowPoint.value;

  if (x > 0 && input[x - 1][y] > current && input[x - 1][y] < 9) {
    final innerLowPoint = LowPoint(x - 1, y, input[x - 1][y]);
    basin.addAll(calculateBasinSize(input, innerLowPoint));
  }

  if (x < input.length - 1 &&
      input[x + 1][y] > current &&
      input[x + 1][y] < 9) {
    final innerLowPoint = LowPoint(x + 1, y, input[x + 1][y]);
    basin.addAll(calculateBasinSize(input, innerLowPoint));
  }

  if (y > 0 && input[x][y - 1] > current && input[x][y - 1] < 9) {
    final innerLowPoint = LowPoint(x, y - 1, input[x][y - 1]);
    basin.addAll(calculateBasinSize(input, innerLowPoint));
  }

  if (y < input[x].length - 1 &&
      input[x][y + 1] > current &&
      input[x][y + 1] < 9) {
    final innerLowPoint = LowPoint(x, y + 1, input[x][y + 1]);
    basin.addAll(calculateBasinSize(input, innerLowPoint));
  }

  return basin;
}

main(List<String> args) => runSolutions((i) => i.asIntList(), part1, part2);

int part1(List<List<int>> input) =>
    findLowPoints(input).map((i) => i.value + 1).sum;

int part2(List<List<int>> input) {
  final lowPoints = findLowPoints(input);

  final basinSizes = lowPoints
      .map((i) => calculateBasinSize(input, i).toSet())
      .map((i) => i.length)
      .toList()
    ..sort();

  return basinSizes
      .sublist(basinSizes.length - 3, basinSizes.length)
      .reduce((a, b) => a * b);
}
