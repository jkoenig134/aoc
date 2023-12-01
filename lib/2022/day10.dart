import '/utils/utils.dart';

class Instruction {
  const Instruction._();

  factory Instruction(String input) {
    if (input == "noop") return NoopInstruction();

    final value = int.parse(input.substring(5));
    return AddInstruction(value);
  }
}

class NoopInstruction extends Instruction {
  const NoopInstruction() : super._();
}

class AddInstruction extends Instruction {
  final int value;

  const AddInstruction(this.value) : super._();
}

main(List<String> args) => runSolutions(
      (i) => i.asString().mapL((e) => Instruction(e)),
      part1,
      part2,
    );

int part1(List<Instruction> input) {
  int returnValue = 0;

  int cycle = 0;
  int x = 1;

  for (final instruction in input) {
    if (instruction is NoopInstruction) {
      cycle++;
      if ([20, 60, 100, 140, 180, 220].contains(cycle)) {
        returnValue += (x * cycle);
      }
    }

    if (instruction is AddInstruction) {
      cycle++;
      if ([20, 60, 100, 140, 180, 220].contains(cycle)) {
        returnValue += (x * cycle);
      }

      cycle++;
      if ([20, 60, 100, 140, 180, 220].contains(cycle)) {
        returnValue += (x * cycle);
      }

      x += instruction.value;
    }
  }

  return returnValue;
}

int part2(List<Instruction> input) {
  return 0;
}
