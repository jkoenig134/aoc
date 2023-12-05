import 'dart:isolate';

import '/utils/utils.dart';

class FieldMappr {
  final List<({int destinationRangeStart, int sourceRangeStart, int rangeLength})> mappings;

  FieldMappr(this.mappings);

  factory FieldMappr.fromString(String input) {
    final entries = input
        .split('\n')
        .sublist(1)
        .map((e) => e.split(' ').map(int.parse).toList())
        .map((e) => (destinationRangeStart: e[0], sourceRangeStart: e[1], rangeLength: e[2]));

    return FieldMappr(entries.toList());
  }

  int map(int source) {
    for (final mapping in mappings) {
      if (source >= mapping.sourceRangeStart && source < mapping.sourceRangeStart + mapping.rangeLength) {
        return mapping.destinationRangeStart + source - mapping.sourceRangeStart;
      }
    }

    return source;
  }
}

class Field {
  final List<int> seeds;

  final FieldMappr seedToSoil;
  final FieldMappr soilToFertilizer;
  final FieldMappr fertilizerToWater;
  final FieldMappr waterToLight;
  final FieldMappr lightToTemperature;
  final FieldMappr temperatureToHumidity;
  final FieldMappr humidityToLocation;

  Field(
    this.seeds,
    this.seedToSoil,
    this.soilToFertilizer,
    this.fertilizerToWater,
    this.waterToLight,
    this.lightToTemperature,
    this.temperatureToHumidity,
    this.humidityToLocation,
  );

  factory Field.fromString(String input) {
    final split = input.split('\n\n');

    final seeds = split[0].substring(7).split(' ').map(int.parse).toList();

    return Field(
      seeds,
      FieldMappr.fromString(split[1]),
      FieldMappr.fromString(split[2]),
      FieldMappr.fromString(split[3]),
      FieldMappr.fromString(split[4]),
      FieldMappr.fromString(split[5]),
      FieldMappr.fromString(split[6]),
      FieldMappr.fromString(split[7]),
    );
  }

  int getLocation(int seed) {
    final soil = seedToSoil.map(seed);
    final fertilizer = soilToFertilizer.map(soil);
    final water = fertilizerToWater.map(fertilizer);
    final light = waterToLight.map(water);
    final temperature = lightToTemperature.map(light);
    final humidity = temperatureToHumidity.map(temperature);
    final location = humidityToLocation.map(humidity);
    return location;
  }
}

main(List<String> args) => runSolutions((i) => Field.fromString(i.raw()), part1, part2);

int part1(Field input) => input.seeds.map(input.getLocation).min;

Future<int> part2(Field input) async {
  final ranges = input.seeds.windowedExclusive(2)..sort((a, b) => a[0].compareTo(b[0]));

  print(ranges);
  // throw UnimplementedError();

  final futures = ranges //
      .map((e) => List.generate(e[1], (index) => e[0] + index))
      .map((e) => Isolate.run(() => e.map(input.getLocation).min));
  final ints = await Future.wait(futures.map((f) async => await f));

  return ints.min;
}
