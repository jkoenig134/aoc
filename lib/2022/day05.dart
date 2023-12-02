import '/utils/utils.dart';

class StackField {
  final List<List<String>> stacks;
  final List<Instruction> instructions;

  StackField(this.instructions, this.stacks);

  factory StackField.fromString(String string) {
    final split = string.split('\n\n');

    final stacks = split[0].split('\n').reversed.toList();
    final stackCount = stacks.first.split('').where((e) => e != ' ').length;

    final instructions = split[1].split('\n').mapL(Instruction.from);

    final field = StackField(
      instructions,
      List.generate(stackCount, (_) => <String>[]),
    );

    for (var line in stacks.skip(1)) {
      for (var i = 0; i < stackCount; i++) {
        final value = line[1 + (i * 4)];
        if (value != ' ') {
          field.stacks[i].add(value);
        }
      }
    }

    return field;
  }

  StackField runInstructionsAsCrateMover9000() {
    for (var instruction in instructions) {
      for (var i = 0; i < instruction.count; i++) {
        final item = stacks[instruction.from].removeLast();
        stacks[instruction.to].add(item);
      }
    }

    return this;
  }

  StackField runInstructionsAsCrateMover9001() {
    for (var instruction in instructions) {
      final old = stacks[instruction.from];

      stacks[instruction.to].addAll(old.sublist(old.length - instruction.count));
      stacks[instruction.from] = old.sublist(0, old.length - instruction.count);
    }

    return this;
  }

  String generateMessageOnTop() => stacks.map((e) => e.last).join();
}

class Instruction {
  final int count;
  final int from;
  final int to;

  Instruction.from(String string)
      : count = int.parse(string.split(' ')[1]),
        from = int.parse(string.split(' ')[3]) - 1,
        to = int.parse(string.split(' ')[5]) - 1;
}

main(List<String> args) => runSolutions(
      (i) => i.raw(),
      part1,
      part2,
    );

String part1(String input) => StackField.fromString(input).runInstructionsAsCrateMover9000().generateMessageOnTop();

String part2(String input) => StackField.fromString(input).runInstructionsAsCrateMover9001().generateMessageOnTop();
