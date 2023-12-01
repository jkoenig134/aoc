import '/utils/utils.dart';

enum Direction { up, down, forward }

class Instruction {
  late Direction direction;
  late int steps;

  Instruction.fromString(String input) {
    final split = input.split(" ");

    switch (split[0]) {
      case "up":
        direction = Direction.up;
        break;
      case "down":
        direction = Direction.down;
        break;
      case "forward":
        direction = Direction.forward;
        break;
    }

    steps = int.parse(split[1]);
  }

  static List<Instruction> fromStringList(List<String> input) =>
      input.map((line) => Instruction.fromString(line)).toList();
}

class Submarine {
  int horizontal = 0;
  int depth = 0;
  int aim = 0;

  void move(Instruction instruction) {
    switch (instruction.direction) {
      case Direction.up:
        aim -= instruction.steps;
        break;
      case Direction.down:
        aim += instruction.steps;
        break;
      case Direction.forward:
        horizontal += instruction.steps;
        depth += aim * instruction.steps;
        break;
    }
  }

  void applyInstructions(List<Instruction> instructions) =>
      instructions.forEach((instruction) => move(instruction));

  int part1() => horizontal * aim;
  int part2() => horizontal * depth;
}

main(List<String> args) => runSolutions(
      (p0) => Submarine()
        ..applyInstructions(Instruction.fromStringList(p0.asString())),
      (p0) => p0.part1(),
      (p0) => p0.part2(),
    );
