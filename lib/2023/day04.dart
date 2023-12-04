import 'dart:math' as math;

import '/utils/utils.dart';

class Card {
  final int id;
  final List<int> winningNumbers;
  final List<int> numbers;
  final int wins;

  Card(this.id, this.winningNumbers, this.numbers) : wins = numbers.where((e) => winningNumbers.contains(e)).length;

  factory Card.fromString(String input) {
    final cardRegex = RegExp(r'^Card +(\d+): ([\d ]*) \| ([\d ]*)$');

    final match = cardRegex.firstMatch(input)!;
    final id = int.parse(match.group(1)!);

    return Card(
      id,
      match.group(2)!.trim().split(RegExp(r' +')).map(int.parse).toList(),
      match.group(3)!.trim().split(RegExp(r' +')).map(int.parse).toList(),
    );
  }

  int? _points;
  int get points {
    if (_points != null) return _points!;

    _points = math.pow(2, wins - 1).toInt();
    return _points!;
  }
}

main(List<String> args) => runSolutions((i) => i.asString().map(Card.fromString).toList(), part1, part2);

int part1(List<Card> input) => input.map((e) => e.points).sum;

int part2(List<Card> input) {
  final counts = {for (var e in input) e.id: (e, 1)};

  counts.forEach((key, value) {
    final indicesWon = List.generate(value.$1.wins, (index) => key + index + 1);

    indicesWon.forEach((i) {
      final other = counts[i]!;
      counts[i] = (other.$1, other.$2 + value.$2);
    });
  });

  return counts.entries.map((e) => e.value.$2).sum;
}
