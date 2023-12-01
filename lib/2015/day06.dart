import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

class OnOffField {
  final List<List<bool>> _field;

  OnOffField()
      : _field = List.generate(1000, (_) => List.generate(1000, (_) => false));

  void runInstruction(String instruction) {
    if (instruction.startsWith("turn on")) {
      final coords = parseCoords(instruction.substring(8));

      for (int x = coords.$1.$1; x <= coords.$2.$1; x++) {
        for (int y = coords.$1.$2; y <= coords.$2.$2; y++) {
          _field[x][y] = true;
        }
      }
    } else if (instruction.startsWith("turn off")) {
      final coords = parseCoords(instruction.substring(9));

      for (int x = coords.$1.$1; x <= coords.$2.$1; x++) {
        for (int y = coords.$1.$2; y <= coords.$2.$2; y++) {
          _field[x][y] = false;
        }
      }
    } else if (instruction.startsWith("toggle")) {
      final coords = parseCoords(instruction.substring(7));

      for (int x = coords.$1.$1; x <= coords.$2.$1; x++) {
        for (int y = coords.$1.$2; y <= coords.$2.$2; y++) {
          _field[x][y] = !_field[x][y];
        }
      }
    } else {
      throw ArgumentError("Unknown instruction: $instruction");
    }
  }

  ((int, int), (int, int)) parseCoords(String coords) {
    final parts = coords.split(" through ");
    final start = parts[0].split(",").map(int.parse).toList();
    final end = parts[1].split(",").map(int.parse).toList();
    return ((start[0], start[1]), (end[0], end[1]));
  }

  int get litCount => _field.expand((row) => row).where((b) => b).length;

  void printField() {
    for (final row in _field) {
      print(row.map((b) => b ? "#" : ".").join());
    }
  }
}

class BrightnessField {
  final List<List<int>> _field;

  BrightnessField()
      : _field = List.generate(1000, (_) => List.generate(1000, (_) => 0));

  void runInstruction(String instruction) {
    if (instruction.startsWith("turn on")) {
      final coords = parseCoords(instruction.substring(8));

      for (int x = coords.$1.$1; x <= coords.$2.$1; x++) {
        for (int y = coords.$1.$2; y <= coords.$2.$2; y++) {
          _field[x][y] = _field[x][y] + 1;
        }
      }
    } else if (instruction.startsWith("turn off")) {
      final coords = parseCoords(instruction.substring(9));

      for (int x = coords.$1.$1; x <= coords.$2.$1; x++) {
        for (int y = coords.$1.$2; y <= coords.$2.$2; y++) {
          _field[x][y] = _field[x][y] - 1;

          if (_field[x][y] < 0) _field[x][y] = 0;
        }
      }
    } else if (instruction.startsWith("toggle")) {
      final coords = parseCoords(instruction.substring(7));

      for (int x = coords.$1.$1; x <= coords.$2.$1; x++) {
        for (int y = coords.$1.$2; y <= coords.$2.$2; y++) {
          _field[x][y] = _field[x][y] + 2;
        }
      }
    } else {
      throw ArgumentError("Unknown instruction: $instruction");
    }
  }

  ((int, int), (int, int)) parseCoords(String coords) {
    final parts = coords.split(" through ");
    final start = parts[0].split(",").map(int.parse).toList();
    final end = parts[1].split(",").map(int.parse).toList();
    return ((start[0], start[1]), (end[0], end[1]));
  }

  int get litCount => _field.map((e) => e.sum).sum;
}

int part1(List<String> input) {
  final field = OnOffField();

  for (final instruction in input) {
    field.runInstruction(instruction);
  }

  return field.litCount;
}

int part2(List<String> input) {
  final field = BrightnessField();

  for (final instruction in input) {
    field.runInstruction(instruction);
  }

  return field.litCount;
}
