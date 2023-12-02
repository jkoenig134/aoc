import '/utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) => i.raw(),
      part1,
      part2,
    );

int findMarkerPositon(String input, int markerSize) {
  final windowed = input.split('').windowed(markerSize);
  for (var i = 0; i < windowed.length; i++) {
    if (windowed[i].allItemsUnique) return i + markerSize;
  }

  throw Exception('No marker found');
}

int part1(String input) => findMarkerPositon(input, 4);
int part2(String input) => findMarkerPositon(input, 14);
