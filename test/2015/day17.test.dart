import 'package:aoc/2015/day17.dart';
import 'package:test/test.dart';

void main() {
  test('fill eggnog', () {
    expect(
      fillEggnog([
        Container(20),
        Container(15),
        Container(10),
        Container(5),
        Container(5),
      ], 25)
          .length,
      4,
    );
  });

  test('number of eggnog with min containers', () {
    expect(
      numberOfEggnogWithMinContainers([
        Container(20),
        Container(15),
        Container(10),
        Container(5),
        Container(5),
      ], 25),
      3,
    );
  });
}
