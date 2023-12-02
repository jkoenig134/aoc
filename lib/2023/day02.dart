import 'package:collection/collection.dart' show IterableExtension;

import '/utils/utils.dart';

typedef GameSet = ({int red, int green, int blue});

class Game {
  final int id;
  final List<GameSet> sets;

  Game(this.id, this.sets);

  factory Game.fromString(String input) {
    final regex = RegExp(r'Game (\d+): (.*)');
    final match = regex.firstMatch(input)!;

    final sets = match.group(2)!.split('; ').map((e) {
      final split = e.split(', ');

      final red = split.firstWhereOrNull((e) => e.endsWith('red'))?.split(' ').first.asInt ?? 0;
      final green = split.firstWhereOrNull((e) => e.endsWith('green'))?.split(' ').first.asInt ?? 0;
      final blue = split.firstWhereOrNull((e) => e.endsWith('blue'))?.split(' ').first.asInt ?? 0;

      return (red: red, green: green, blue: blue);
    }).toList();

    return Game(int.parse(match.group(1)!), sets);
  }

  bool get isValid => sets.every((s) => s.red <= 12 && s.green <= 13 && s.blue <= 14);
  int get power => sets.map((e) => e.red).max * sets.map((e) => e.green).max * sets.map((e) => e.blue).max;
}

main(List<String> args) => runSolutions((i) => i.asString().map(Game.fromString).toList(), part1, part2);

int part1(List<Game> games) => games.where((game) => game.isValid).map((e) => e.id).toList().sum;

int part2(List<Game> input) => input.map((e) => e.power).sum;
