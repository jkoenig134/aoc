import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

class Instruction {
  final String whatToDo;
  int? cache;

  Instruction(this.whatToDo);

  int run(Map<String, Instruction> instructions) {
    if (cache != null) return cache!;

    if (int.tryParse(whatToDo) != null) {
      final num = int.parse(whatToDo);
      cache = num;
      return num;
    }

    if (instructions.containsKey(whatToDo)) {
      return instructions[whatToDo]!.run(instructions);
    }

    if (whatToDo.startsWith("NOT ")) {
      final input = whatToDo.substring(4);

      final num = ~instructions[input]!.run(instructions) & 0xFFFF;
      cache = num;
      return num;
    }

    if (whatToDo.contains(" LSHIFT ")) {
      final split = whatToDo.split(" LSHIFT ");
      final input = split[0];
      final shift = int.parse(split[1]);

      final num = instructions[input]!.run(instructions) << shift;
      cache = num;
      return num;
    }

    if (whatToDo.contains(" RSHIFT ")) {
      final split = whatToDo.split(" RSHIFT ");
      final input = split[0];
      final shift = int.parse(split[1]);

      final num = instructions[input]!.run(instructions) >> shift;
      cache = num;
      return num;
    }

    if (whatToDo.contains(" AND ")) {
      final split = whatToDo.split(" AND ");
      final input1 = split[0];
      final input2 = split[1];

      final left = int.tryParse(input1) != null
          ? int.parse(input1)
          : instructions[input1]!.run(instructions);

      final right = int.tryParse(input2) != null
          ? int.parse(input2)
          : instructions[input2]!.run(instructions);

      final num = left & right;
      cache = num;
      return num;
    }

    if (whatToDo.contains(" OR ")) {
      final split = whatToDo.split(" OR ");
      final input1 = split[0];
      final input2 = split[1];

      final left = int.tryParse(input1) != null
          ? int.parse(input1)
          : instructions[input1]!.run(instructions);

      final right = int.tryParse(input2) != null
          ? int.parse(input2)
          : instructions[input2]!.run(instructions);

      final num = left | right;
      cache = num;
      return num;
    }

    throw "Unknown instruction: $whatToDo";
  }
}

int part1(List<String> input) {
  final instructions = _parse(input);
  return instructions["a"]!.run(instructions);
}

int part2(List<String> input) {
  final p1 = part1(input);
  final instructions = _parse(input);

  instructions["b"]!.cache = p1;

  return instructions["a"]!.run(instructions);
}

Map<String, Instruction> _parse(List<String> input) {
  final instructions = <String, Instruction>{};

  for (String instruction in input) {
    final split = instruction.split(" -> ");
    final outputWire = split[1];

    final whatToDo = split[0];

    instructions[outputWire] = Instruction(whatToDo);
  }

  return instructions;
}
