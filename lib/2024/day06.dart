import 'dart:io';
import 'dart:math';

import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asStringList(), part1, part2);

sealed class Field {}

class Obstacle implements Field {}

class Steppable implements Field {
  bool wasVisited = false;
}

class Map {
  final List<List<Field>> fields;

  Point<int> guardLocation;
  Direction guardDirection;

  int get steppedFields => fields.map((e) => e.map((e) => e is Steppable && e.wasVisited ? 1 : 0).sum).sum;

  Map._(this.fields, this.guardLocation, this.guardDirection);

  factory Map.fromInput(List<List<String>> input) {
    Point<int>? guardLocation;
    Direction? guardDirection;

    final fields = input
        .mapIndexed((e, x) => e.mapIndexed((e, y) {
              switch (e) {
                case '#':
                  return Obstacle();
                case '.':
                  return Steppable();
                default:
                  if (guardLocation != null) throw Exception('Multiple guards found');

                  guardLocation = Point(x, y);
                  guardDirection = Direction.fromCarets(e);

                  return Steppable();
              }
            }).toList())
        .toList();

    if (guardLocation == null) throw Exception('Multiple guards found');

    return Map._(fields, guardLocation!, guardDirection!);
  }

  int walkGuardUntilLeavingMap() {
    (fields[guardLocation.x][guardLocation.y] as Steppable).wasVisited = true;

    while (true) {
      final newGuardLocation = guardLocation +
          switch (guardDirection) {
            Direction.up => Point(-1, 0),
            Direction.down => Point(1, 0),
            Direction.left => Point(0, -1),
            Direction.right => Point(0, 1),
          };

      if (newGuardLocation.x < 0 || newGuardLocation.x >= fields.length || newGuardLocation.y < 0 || newGuardLocation.y >= fields[0].length) {
        break;
      }

      if (fields[newGuardLocation.x][newGuardLocation.y] is Obstacle) {
        turnRight();
      } else {
        guardLocation = newGuardLocation;
        (fields[guardLocation.x][guardLocation.y] as Steppable).wasVisited = true;
      }
    }

    return steppedFields;
  }

  void turnRight() {
    guardDirection = switch (guardDirection) {
      Direction.up => Direction.right,
      Direction.right => Direction.down,
      Direction.down => Direction.left,
      Direction.left => Direction.up,
    };
  }

  void debugPrint() {
    for (var x = 0; x < fields.length; x++) {
      for (var y = 0; y < fields[x].length; y++) {
        if (guardLocation.x == x && guardLocation.y == y) {
          stdout.write(guardDirection.asCaret());
        } else {
          final field = fields[x][y];
          switch (field) {
            case Obstacle():
              stdout.write('#');
              break;
            case Steppable():
              stdout.write(field.wasVisited ? 'X' : '.');
              break;
          }
        }
      }
      stdout.write('\n');
    }
  }
}

int part1(List<List<String>> input) => Map.fromInput(input).walkGuardUntilLeavingMap();

int part2(List<List<String>> input) {
  return 0;
}
