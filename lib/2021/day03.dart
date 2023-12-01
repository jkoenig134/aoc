import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asStringList(), part1, part2);

int part1(List<List<String>> input) {
  final flipped = input.flipped();
  String epsilon = "", gamma = "";

  for (final bits in flipped) {
    final oneLength = bits.where((e) => e == "1").length;
    final zeroLength = bits.where((e) => e == "0").length;

    if (oneLength > zeroLength) {
      epsilon += "0";
      gamma += "1";
    } else {
      epsilon += "1";
      gamma += "0";
    }
  }

  return epsilon.binaryToDecimal * gamma.binaryToDecimal;
}

enum LifeSupport { oxygenGenerator, co2Scrubber }

int part2(List<List<String>> input) {
  final oxygenGeneratorRating = processLifeSupportRating(
    input,
    LifeSupport.oxygenGenerator,
  );
  final co2ScrubberRating = processLifeSupportRating(
    input,
    LifeSupport.co2Scrubber,
  );

  return oxygenGeneratorRating * co2ScrubberRating;
}

int processLifeSupportRating(
  List<List<String>> input,
  LifeSupport lifeSupport,
) {
  int row = 0;

  final copy =
      input.map((row) => row.map((element) => element).toList()).toList();

  while (copy.length > 1) {
    final flipped = copy.flipped();

    final bits = flipped[row];
    final oneLength = bits.where((element) => element == "1").length;
    final zeroLength = bits.where((element) => element == "0").length;

    if (lifeSupport == LifeSupport.co2Scrubber) {
      if (zeroLength > oneLength) {
        copy.removeWhere((element) => element[row] == "0");
      } else {
        copy.removeWhere((element) => element[row] == "1");
      }
    } else {
      if (oneLength < zeroLength) {
        copy.removeWhere((element) => element[row] == "1");
      } else {
        copy.removeWhere((element) => element[row] == "0");
      }
    }

    row++;
  }

  return copy[0].join().binaryToDecimal;
}
