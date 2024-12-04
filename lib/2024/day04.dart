import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asStringList(), part1, part2);

int part1(List<List<String>> input) {
  final xmas = RegExp(r'(?=(XMAS|SAMX))');

  final horizontalXmases = input.map((e) => xmas.allMatches(e.join('')).length).sum;
  final verticalXmases = input.flipped().map((e) => xmas.allMatches(e.join('')).length).sum;
  final diagonalXmases = input.diagonal().map((e) => xmas.allMatches(e.join('')).length).sum;
  final diagonalXmases2 = input.map((e) => e.reversed.toList()).toList().diagonal().map((e) => xmas.allMatches(e.join('')).length).sum;

  return horizontalXmases + verticalXmases + diagonalXmases + diagonalXmases2;
}

int part2(List<List<String>> input) {
  int xMASes = 0;

  for (int i = 0; i <= input.length - 3; i++) {
    for (int j = 0; j <= input[i].length - 3; j++) {
      final middle = input[i + 1][j + 1];
      if (middle != 'A') continue;

      final leftTop = input[i][j];
      final rightBottom = input[i + 2][j + 2];
      final leftTopAndRightBottomAreMS = (leftTop == 'M' && rightBottom == 'S') || (leftTop == 'S' && rightBottom == 'M');

      final leftBottom = input[i + 2][j];
      final rightTop = input[i][j + 2];
      final leftBottomAndRightTopAreMS = (leftBottom == 'M' && rightTop == 'S') || (leftBottom == 'S' && rightTop == 'M');

      if (leftTopAndRightBottomAreMS && leftBottomAndRightTopAreMS) xMASes++;
    }
  }

  return xMASes;
}
