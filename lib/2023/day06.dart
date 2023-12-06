import '/utils/utils.dart';

typedef BoatRace = ({int time, int distance});

List<BoatRace> parseBoatRaces(String input) {
  final lines = input.split('\n');

  final times = lines[0].replaceAll(RegExp(r'Time: +'), '').split(RegExp(r' +')).map(int.parse).toList();
  final distances = lines[1].replaceAll(RegExp(r'Distance: +'), '').split(RegExp(r' +')).map(int.parse).toList();

  return times.mapIndexed((e, index) => (time: e, distance: distances[index]));
}

extension AsSingle on List<BoatRace> {
  BoatRace get asSingleBoatRace => (
        time: map((e) => e.time.toString()).join().asInt,
        distance: map((e) => e.distance.toString()).join().asInt,
      );
}

int calculateNumbersOfWinningPresses(BoatRace boatRace) {
  final time = boatRace.time;

  var minWinningPresses = 0;
  var maxWinningPresses = 0;

  for (int i = 0; i <= time; i++) {
    final boatDistance = (time - i) * i;
    if (boatDistance > boatRace.distance) {
      minWinningPresses = i;
      break;
    }
  }

  for (int i = time; i >= 0; i--) {
    final boatDistance = (time - i) * i;
    if (boatDistance > boatRace.distance) {
      maxWinningPresses = i;
      break;
    }
  }

  return maxWinningPresses - minWinningPresses + 1;
}

main(List<String> args) => runSolutions((i) => parseBoatRaces(i.raw()), part1, part2);

int part1(List<BoatRace> input) => input.map(calculateNumbersOfWinningPresses).mul;

int part2(List<BoatRace> input) => calculateNumbersOfWinningPresses(input.asSingleBoatRace);
