import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asStringList(), part1, part2);

int part1(List<List<String>> input) => stepXTimes(input, 100);
int part2(List<List<String>> input) => stepXTimes(input, 100, keepCornersOn: true);

int stepXTimes(
  List<List<String>> input,
  int times, {
  bool keepCornersOn = false,
}) {
  var current = input;

  for (int i = 0; i < times; i++) {
    current = step(current, keepCornersOn: keepCornersOn);
  }

  return current.expand((e) => e).where((e) => e == '#').length;
}

List<List<String>> step(
  List<List<String>> input, {
  bool keepCornersOn = false,
}) {
  final gridSize = input.length;

  if (keepCornersOn) {
    input[0][0] = '#';
    input[0][gridSize - 1] = '#';
    input[gridSize - 1][0] = '#';
    input[gridSize - 1][gridSize - 1] = '#';
  }

  final out = List.generate(gridSize, (_) => List.filled(gridSize, '.'));

  for (int x = 0; x < out.length; x++) {
    for (int y = 0; y < out.length; y++) {
      final neighbors = [
        (x - 1, y - 1),
        (x - 1, y),
        (x - 1, y + 1),
        (x, y - 1),
        (x, y + 1),
        (x + 1, y - 1),
        (x + 1, y),
        (x + 1, y + 1),
      ].where(
        (n) => n.$1 >= 0 && n.$2 >= 0 && n.$1 < gridSize && n.$2 < gridSize,
      );

      final currentState = input[x][y];
      final onNeighbors = neighbors.where((n) => input[n.$1][n.$2] == '#').length;

      final nextState = switch ((currentState, onNeighbors)) {
        ('#', 2) || ('#', 3) => '#',
        ('.', 3) => '#',
        _ => '.',
      };

      out[x][y] = nextState;
    }
  }

  if (keepCornersOn) {
    out[0][0] = '#';
    out[0][gridSize - 1] = '#';
    out[gridSize - 1][0] = '#';
    out[gridSize - 1][gridSize - 1] = '#';
  }

  return out;
}
