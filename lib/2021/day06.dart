import '/utils/utils.dart';

class Swarm {
  final fishes = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  int get numberOfFishes => fishes.sum;

  Swarm(String input) {
    input
        .split(',')
        .map(int.parse)
        .forEach((age) => fishes[age] = fishes[age] + 1);
  }

  void age() {
    final zeroes = fishes.removeAt(0);
    fishes[6] = fishes[6] + zeroes;
    fishes.add(zeroes);
  }

  Swarm ageForDays(int days) {
    for (int i = 0; i < days; i++) {
      age();
    }
    return this;
  }
}

main(List<String> args) => runSolutions(
      (i) => Swarm(i.raw()),
      (swarm) => swarm.ageForDays(80).numberOfFishes,
      (swarm) => swarm.ageForDays(256 - 80).numberOfFishes,
    );
