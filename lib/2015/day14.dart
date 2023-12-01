import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

class Reindeer {
  final int _speed;
  final int _flyTime;
  final int _restTime;

  int _currentSecond = 0;
  int currentKm = 0;
  int points = 0;

  Reindeer(this._speed, this._flyTime, this._restTime);
  factory Reindeer.fromString(String input) {
    final regex = RegExp(
        r"\w+ can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.");

    final matches = regex.allMatches(input).first;

    final speed = int.parse(matches.group(1)!);
    final flyTime = int.parse(matches.group(2)!);
    final restTime = int.parse(matches.group(3)!);

    return Reindeer(speed, flyTime, restTime);
  }

  int distanceAfter(int seconds) {
    var cycleTime = _flyTime + _restTime;
    var cycles = seconds ~/ cycleTime;
    var remaining = seconds % cycleTime;
    var distance = cycles * _flyTime * _speed;
    distance += remaining < _flyTime ? remaining * _speed : _flyTime * _speed;
    return distance;
  }

  void raceOneSecond() {
    final isFlying = _currentSecond % (_flyTime + _restTime) < _flyTime;
    if (isFlying) currentKm += _speed;

    _currentSecond++;
  }
}

int part1(List<String> input) =>
    input.map(Reindeer.fromString).map((r) => r.distanceAfter(2503)).max;

int part2(List<String> input) {
  final reindeers = input.map(Reindeer.fromString).toList();

  for (var i = 1; i <= 2503; i++) {
    reindeers.forEach((element) => element.raceOneSecond());

    final leadDistance = reindeers.map((r) => r.currentKm).max;
    reindeers
        .where((r) => r.currentKm == leadDistance)
        .forEach((element) => element.points++);
  }

  return reindeers.map((r) => r.points).max;
}
