import '/utils/utils.dart';

class CleaningSection {
  final int leftBound;
  final int rightBound;

  CleaningSection(this.leftBound, this.rightBound);

  CleaningSection.fromString(String string)
      : leftBound = int.parse(string.split('-')[0]),
        rightBound = int.parse(string.split('-')[1]);

  bool contains(CleaningSection other) =>
      (other.leftBound >= leftBound && other.rightBound <= rightBound) ||
      (leftBound >= other.leftBound && rightBound <= other.rightBound);

  bool overlaps(CleaningSection other) =>
      (leftBound >= other.leftBound && leftBound <= other.rightBound) ||
      (other.leftBound >= leftBound && other.leftBound <= rightBound);
}

main(List<String> args) => runSolutions(
      (i) => i
          .asString()
          .mapL((e) => e.split(',').mapL(CleaningSection.fromString)),
      part1,
      part2,
    );

int part1(List<List<CleaningSection>> input) =>
    input.where((e) => e[0].contains(e[1])).length;

int part2(List<List<CleaningSection>> input) =>
    input.where((e) => e[0].overlaps(e[1])).length;
