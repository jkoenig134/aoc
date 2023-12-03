import '/utils/utils.dart';

class EnginePart {
  final int id;

  final int x;
  final ({int from, int to}) y;

  bool? _isValid;
  (int, int)? foundGear;

  EnginePart(this.id, this.x, this.y);

  @override
  String toString() => 'EnginePart($id, $x, $y, $_isValid, $foundGear)';

  bool isValid(List<List<String>> grid) {
    if (_isValid != null) return _isValid!;

    for (int y = this.y.from; y <= this.y.to; y++) {
      final neighbors = grid.neighbors(x, y);

      for (final neighbor in neighbors) {
        final char = grid[neighbor.$1][neighbor.$2];
        if (char != '.' && int.tryParse(char) == null) {
          if (char == '*') foundGear = neighbor;

          _isValid = true;
        }
      }
    }

    return _isValid ?? false;
  }
}

class EngineSchematic {
  final List<List<String>> grid;
  final List<EnginePart> engineParts;

  EngineSchematic(this.grid, this.engineParts);

  factory EngineSchematic.fromString(String input) {
    final lines = input.trim().split('\n');
    final grid = lines.map((line) => line.split('')).toList();

    final numberRegex = RegExp(r'\d+');
    final engineParts = <EnginePart>[];

    for (final line in lines.indexed) {
      final matches = numberRegex.allMatches(line.$2);

      for (final match in matches) {
        final part = EnginePart(int.parse(match.group(0)!), line.$1, (from: match.start, to: match.end - 1));
        engineParts.add(part);
      }
    }

    return EngineSchematic(grid, engineParts);
  }

  List<EnginePart> get validParts => engineParts.where((part) => part.isValid(grid)).toList();
}

main(List<String> args) => runSolutions((i) => EngineSchematic.fromString(i.raw()), part1, part2);

int part1(EngineSchematic input) => input.validParts.map((e) => e.id).sum;

int part2(EngineSchematic input) {
  final gears = input.validParts
      .where((e) => e.foundGear != null && input.validParts.where((m) => m.foundGear == e.foundGear && m.id != e.id).length == 1)
      .map((e) => e.foundGear)
      .toSet();

  return gears.map((g) => input.validParts.where((e) => e.foundGear == g).map((p) => p.id).mul).sum;
}
