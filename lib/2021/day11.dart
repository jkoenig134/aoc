import '/utils/utils.dart';

class Octopus {
  final int x;
  final int y;

  int lightLevel;
  bool flashed = false;

  Octopus(this.x, this.y, this.lightLevel);

  void increaseLightlevel() => lightLevel++;

  bool reset() {
    if (!flashed) return false;

    lightLevel = 0;
    flashed = false;
    return true;
  }
}

class OctopusGrid {
  final List<List<Octopus>> octoGrid;
  late List<Octopus> octoList;

  int _steps = 0;

  OctopusGrid(List<List<int>> input)
      : octoGrid = [
          for (var x = 0; x < input.length; x++)
            [
              for (var y = 0; y < input[x].length; y++)
                Octopus(
                  x,
                  y,
                  input[x][y],
                )
            ]
        ] {
    octoList = octoGrid.expand((x) => x).toList();
  }

  List<Octopus> surroundingOctos(int x, int y) {
    final maxLength = octoGrid.length - 1;
    return [
      if (x > 0 && y > 0) octoGrid[x - 1][y - 1],
      if (y > 0) octoGrid[x][y - 1],
      if (y > 0 && x < maxLength) octoGrid[x + 1][y - 1],
      if (x > 0) octoGrid[x - 1][y],
      if (x < maxLength) octoGrid[x + 1][y],
      if (x > 0 && y < maxLength) octoGrid[x - 1][y + 1],
      if (y < maxLength) octoGrid[x][y + 1],
      if (x < maxLength && y < maxLength) octoGrid[x + 1][y + 1]
    ];
  }

  void increaseLightLevelOfSourrounding(Octopus octo) {
    if (octo.flashed || octo.lightLevel < 9) return;
    octo.flashed = true;
    surroundingOctos(octo.x, octo.y).forEach((o) => o.increaseLightlevel());
  }

  int flash() {
    _steps++;
    octoList.forEach((e) => e.increaseLightlevel());

    while (octoList.any((e) => e.lightLevel > 9 && !e.flashed)) {
      octoList.where((e) => e.lightLevel > 9 && !e.flashed).forEach((e) => increaseLightLevelOfSourrounding(e));
    }

    return octoGrid.map((e) => e.map((e) => e.reset()).where((f) => f).length).sum;
  }

  int synchronize() {
    while (flash() != 100) {}
    return _steps;
  }
}

main(List<String> args) => runSolutions((i) => OctopusGrid(i.asIntList()), part1, part2);

int part1(OctopusGrid grid) => [for (var i = 0; i < 100; i++) grid.flash()].sum;

int part2(OctopusGrid grid) => grid.synchronize();
