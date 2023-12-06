import 'package:aoc/2023/day06.dart';
import 'package:test/test.dart';

void main() {
  final testInput = '''Time:      7  15   30
Distance:  9  40  200''';

  final testBoatRaces = parseBoatRaces(testInput);

  test('calculateNumbersOfWinningPresses', () {
    expect(calculateNumbersOfWinningPresses(testBoatRaces[0]), 4);
    expect(calculateNumbersOfWinningPresses(testBoatRaces[1]), 8);
    expect(calculateNumbersOfWinningPresses(testBoatRaces[2]), 9);
  });

  test('part 1', () => expect(part1(testBoatRaces), 288));

  test('asSingleBoatRace', () {
    final single = testBoatRaces.asSingleBoatRace;

    expect(single.time, 71530);
    expect(single.distance, 940200);
  });

  test('part 2', () => expect(part2(testBoatRaces), 71503));
}
