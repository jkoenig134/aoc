import 'dart:math';

import '/utils/utils.dart';

class Instruction {
  final Direction direction;
  final int value;

  Instruction(this.direction, this.value);
  factory Instruction.fromString(String s) => Instruction(
        Direction.fromString(s.substring(0, 1)),
        int.parse(s.substring(2)),
      );
}

main(List<String> args) => runSolutions(
      (i) => i.asString().mapL(Instruction.fromString),
      part1,
      part2,
    );

int runInstructionsWithRopeLength(
  List<Instruction> instructions,
  int ropeLength,
) {
  final tailPositions = <Point<int>>{};
  final rope = List.generate(ropeLength, (index) => Point(0, 0));

  instructions.forEach((element) {
    for (var i = 0; i < element.value; i++) {
      rope[0] = rope.first.moveInDirection(element.direction);

      for (var i = 1; i < rope.length; i++) {
        final leader = rope[i - 1];
        final current = rope[i];

        double distance = current.distanceTo(leader);
        if (distance < 1.5) break;

        rope[i] += Point(
          (leader.x - current.x).sign,
          (leader.y - current.y).sign,
        );
      }

      tailPositions.add(rope.last);
    }
  });

  return tailPositions.length;
}

int part1(List<Instruction> input) => runInstructionsWithRopeLength(input, 2);
int part2(List<Instruction> input) => runInstructionsWithRopeLength(input, 10);
