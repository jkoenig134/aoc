import 'package:aoc/2023/day07.dart';
import 'package:test/test.dart';

void main() {
  final testInput = '''32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483''';

  final testHands = testInput.split('\n').map(Hand.fromString).toList();

  test('Hand power', () {
    expect(testHands[0].power(), 2);
    expect(testHands[1].power(), 4);
    expect(testHands[2].power(), 3);
    expect(testHands[3].power(), 3);
    expect(testHands[4].power(), 4);
  });

  test('part 1', () => expect(part1(testHands), 6440));

  test('JokerHand power', () {
    expect(testHands[0].power(useJokers: true), 2);
    expect(testHands[1].power(useJokers: true), 6);
    expect(testHands[2].power(useJokers: true), 3);
    expect(testHands[3].power(useJokers: true), 6);
    expect(testHands[4].power(useJokers: true), 6);
    expect(Hand.fromString('3JQ34 1').power(useJokers: true), 4);
  });

  test('part 2', () => expect(part2(testHands), 5905));
}
