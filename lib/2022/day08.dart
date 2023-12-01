import 'dart:math';

import '/utils/utils.dart';

class Tree {
  final int height;
  final int x;
  final int y;
  bool visible = false;

  Tree(this.height, this.x, this.y);

  int _scenicScore(List<List<Tree>> input, Direction direction) {
    var score = 0;

    final isOnX = direction == Direction.left || direction == Direction.right;

    while (true) {
      final valueToAlter = isOnX ? x : y;
      final position = direction == Direction.left || direction == Direction.up
          ? (valueToAlter - score - 1)
          : (valueToAlter + score + 1);

      if (position > input.length - 1 || position < 0) {
        break;
      }

      score++;
      final value =
          isOnX ? input[y][position].height : input[position][x].height;
      if (value >= height) {
        break;
      }
    }

    return score;
  }

  int scenicScore(List<List<Tree>> input) => Direction.values
      .map((e) => _scenicScore(input, e))
      .reduce((a, b) => a * b);
}

main(List<String> args) => runSolutions(
      (i) => i.asStringList().mapIndexed(
            (e, y) => e.mapIndexed((e, x) => Tree(int.parse(e), x, y)),
          ),
      part1,
      part2,
    );

void markVisible(List<List<Tree>> input) {
  for (var row in input) {
    var lastHeight = row[0].height;
    row[0].visible = true;

    for (var tree in row.skip(1)) {
      if (tree.height > lastHeight) {
        tree.visible = true;
        lastHeight = tree.height;
      }
    }
  }
}

int part1(List<List<Tree>> input) {
  markVisible(input);
  markVisible(input.mapL((e) => e.reversed.toList()));

  final flipped = input.flipped().toList();
  markVisible(flipped);
  markVisible(flipped.mapL((e) => e.reversed.toList()));

  return input.expand((e) => e).where((e) => e.visible).length;
}

int part2(List<List<Tree>> input) => input
    .map((e) => e.map((e) => e.scenicScore(input)))
    .expand((element) => element)
    .reduce(max);
