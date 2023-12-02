import '/utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) => i.asString().mapL((e) => RPSGame.fromString(e)),
      part1,
      part2,
    );

enum RPS {
  rock(1),
  paper(2),
  scissors(3);

  const RPS(this.value);
  final int value;

  RPS get beats {
    switch (this) {
      case RPS.paper:
        return RPS.rock;
      case RPS.scissors:
        return RPS.paper;
      case RPS.rock:
        return RPS.scissors;
    }
  }

  RPS get isBeatenBy => beats.beats;

  static RPS fromString(String s) {
    switch (s) {
      case 'A':
      case 'X':
        return RPS.rock;
      case 'B':
      case 'Y':
        return RPS.paper;
      case 'C':
      case 'Z':
        return RPS.scissors;
      default:
        throw Exception('Unknown RPS: $s');
    }
  }
}

class RPSGame {
  final RPS opponent;
  final String ownMove;

  RPSGame(this.opponent, this.ownMove);
  factory RPSGame.fromString(String s) => RPSGame(RPS.fromString(s[0]), s[2]);

  int _calculateScore(RPS self, RPS other) {
    if (self.value == other.value) return 3 + self.value;
    if (other == self.beats) return 6 + self.value;
    return self.value;
  }

  int scoreAgainstWithOwnMoveFromString() => _calculateScore(
        RPS.fromString(ownMove),
        opponent,
      );

  int scoreAgainstWithWinCondition() {
    switch (ownMove) {
      case 'X':
        return _calculateScore(opponent.beats, opponent);
      case 'Y':
        return _calculateScore(opponent, opponent);
      case 'Z':
        return _calculateScore(opponent.isBeatenBy, opponent);
      default:
        throw Exception('Unknown win condition: $ownMove');
    }
  }
}

int part1(List<RPSGame> input) => input.map((e) => e.scoreAgainstWithOwnMoveFromString()).sum;

int part2(List<RPSGame> input) => input.map((e) => e.scoreAgainstWithWinCondition()).sum;
