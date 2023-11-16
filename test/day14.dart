import 'package:aoc2015/day14.dart';
import 'package:test/test.dart';

void main() {
  final comet = Reindeer.fromString(
    "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
  );
  final dancer = Reindeer.fromString(
    "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.",
  );

  test("distance after", () {
    expect(comet.distanceAfter(1000), 1120);
    expect(dancer.distanceAfter(1000), 1056);
  });

  test("correct racing per second", () {
    for (var i = 0; i < 1000; i++) {
      comet.raceOneSecond();
      dancer.raceOneSecond();

      if (comet.currentKm == dancer.currentKm) {
        comet.points++;
        dancer.points++;
      } else if (comet.currentKm > dancer.currentKm) {
        comet.points++;
      } else {
        dancer.points++;
      }
    }

    expect(comet.points, 312);
    expect(dancer.points, 689);
  });
}
