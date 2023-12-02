import 'dart:math';

import '/utils/utils.dart';

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);
}

enum Direction { x, y }

class Instruction {
  final Direction direction;
  final int position;

  Instruction.fromString(String instruction)
      : direction = Direction.values.byName(instruction[11]),
        position = int.parse(instruction.substring(13));
}

class TransparentPaper {
  late List<Instruction> instructions;
  late List<List<String>> paper;

  TransparentPaper(String input) {
    final split = input.split('\n\n');

    final points = split[0]
        .split('\n')
        .map((e) => e.split(','))
        .map((e) => Point(int.parse(e[0]), int.parse(e[1])));

    final maxX = points.map((e) => e.x).reduce(max);
    final maxY = points.map((e) => e.y).reduce(max);

    paper = List.generate(maxY + 1, (y) => List.generate(maxX + 1, (x) => ' '));
    points.forEach((p) => paper[p.y][p.x] = '#');

    instructions =
        split[1].split('\n').map((e) => Instruction.fromString(e)).toList();
  }

  TransparentPaper fold() {
    final instruction = instructions.removeAt(0);

    final newPaper =
        instruction.direction == Direction.x ? paper : paper.flipped().toList();

    for (var i = 0; i < newPaper.length; i++) {
      final row = newPaper[i];

      final newRow = row.sublist(0, instruction.position);

      final leftOver = row.sublist(instruction.position + 1);
      for (var j = 0; j < leftOver.length; j++) {
        final newRowIndex = newRow.length - 1 - j;

        if (newRow[newRowIndex] == ' ') {
          newRow[newRowIndex] = leftOver[j];
        }
      }

      newPaper[i] = newRow;
    }

    paper = instruction.direction == Direction.x
        ? newPaper
        : newPaper.flipped().toList();

    return this;
  }

  int get taggedFields => paper.map((e) => e.where((e) => e == '#').length).sum;

  String finishFolding() {
    while (instructions.isNotEmpty) {
      fold();
    }

    final folded = paper.map((row) => row.join('')).join('\n');
    return '\n$folded';
  }
}

main(List<String> args) =>
    runSolutions((i) => TransparentPaper(i.raw()), part1, part2);

int part1(TransparentPaper paper) => paper.fold().taggedFields;

String part2(TransparentPaper input) => input.finishFolding();
