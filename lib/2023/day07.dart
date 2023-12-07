import '/utils/utils.dart';

class Hand {
  final int bid;
  final List<String> cards;

  Hand(this.bid, this.cards);

  factory Hand.fromString(String input) {
    final words = input.split(' ');
    return Hand(int.parse(words[1]), words[0].split('').toList());
  }

  int compareTo(Hand other, {bool useJokers = false}) {
    final ownPower = power(useJokers: useJokers);
    final otherPower = other.power(useJokers: useJokers);
    if (ownPower != otherPower) return ownPower.compareTo(otherPower);

    final values = cards.map((e) => _charToValue(e, useJokers)).toList();
    final otherValues = other.cards.map((e) => _charToValue(e, useJokers)).toList();
    for (var card in values.indexed) {
      final compared = card.$2.compareTo(otherValues[card.$1]);
      if (compared != 0) return compared;
    }

    throw Exception('Hands are equal: $this, $other');
  }

  int power({bool useJokers = false}) {
    final cardValues = cards.map((e) => _charToValue(e, useJokers));

    final numberOfJokers = cardValues.where((e) => e == 1).length;

    final counts = <int, int>{};
    for (final card in cardValues.where((e) => e != 1)) {
      counts[card] = (counts[card] ?? 0) + 1;
    }

    final entries = counts.entries.toList();

    if (entries.any((e) => e.value == 5 - numberOfJokers) || numberOfJokers == 5) {
      return 7;
    } else if (entries.any((e) => e.value == 4 - numberOfJokers)) {
      return 6;
    } else if ((entries.any((e) => e.value == 2) && entries.any((e) => e.value == 3)) ||
        (numberOfJokers == 1 && entries.where((e) => e.value == 2).length == 2) ||
        (numberOfJokers == 2 && entries.where((e) => e.value == 2).length == 1)) {
      return 5;
    } else if (entries.any((e) => e.value == 3 - numberOfJokers)) {
      return 4;
    } else if (entries.where((e) => e.value == 2).length == 2 || numberOfJokers == 1 && entries.where((e) => e.value == 2).length == 1) {
      return 3;
    } else if (entries.where((e) => e.value == 2).length == 1 || numberOfJokers == 1) {
      return 2;
    } else {
      return 1;
    }
  }

  int _charToValue(String char, bool useJokers) => switch (char) {
        'A' => 14,
        'K' => 13,
        'Q' => 12,
        'J' => useJokers ? 1 : 11,
        'T' => 10,
        '9' => 9,
        '8' => 8,
        '7' => 7,
        '6' => 6,
        '5' => 5,
        '4' => 4,
        '3' => 3,
        '2' => 2,
        _ => throw Exception('Invalid card value: $char')
      };
}

main(List<String> args) => runSolutions((i) => i.asString().map(Hand.fromString).toList(), part1, part2);

int part1(List<Hand> input) => (input..sort((a, b) => a.compareTo(b))).mapIndexed((e, index) => (index + 1) * e.bid).sum;

int part2(List<Hand> input) => (input..sort((a, b) => a.compareTo(b, useJokers: true))).mapIndexed((e, index) => (index + 1) * e.bid).sum;
