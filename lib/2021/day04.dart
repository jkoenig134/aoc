import '/utils/utils.dart';

class BingoField {
  final int value;
  bool checked = false;

  BingoField(this.value);

  void submit(int number) {
    if (number == value) checked = true;
  }
}

class BingoBoard {
  late final List<List<BingoField>> rows;
  late final List<List<BingoField>> columns;

  BingoBoard.fromString(String input) {
    rows = input
        .split("\n")
        .map(
          (e) => e
              .replaceAll("  ", " ")
              .replaceFirst(RegExp("^ "), "")
              .split(" ")
              .map((e) => BingoField(int.parse(e)))
              .toList(),
        )
        .toList();

    columns = rows.flipped();
  }

  bool _isWinner() =>
      rows.any((r) => r.every((f) => f.checked)) ||
      columns.any((c) => c.every((f) => f.checked));

  bool submitNumber(int number) {
    rows.forEach((row) => row.forEach((field) => field.submit(number)));
    columns.forEach((col) => col.forEach((field) => field.submit(number)));

    return _isWinner();
  }

  int uncheckedSum() => rows
      .map((row) => row.where((f) => !f.checked).map((f) => f.value).sum)
      .sum;
}

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

int part1(String input) {
  final splitted = input.split("\n\n");

  final bingoInstructions = splitted[0].split(",").map(int.parse).toList();
  splitted.removeAt(0);

  final bingoBoards = splitted.map((e) => BingoBoard.fromString(e)).toList();

  for (final instruction in bingoInstructions) {
    for (final board in bingoBoards) {
      if (board.submitNumber(instruction)) {
        final uncheckedSum = board.uncheckedSum();
        return uncheckedSum * instruction;
      }
    }
  }

  return 0;
}

int part2(String input) {
  final splitted = input.split("\n\n");

  final bingoInstructions = splitted[0].split(",").map(int.parse).toList();
  splitted.removeAt(0);

  final bingoBoards = splitted.map((e) => BingoBoard.fromString(e)).toList();

  for (final instruction in bingoInstructions) {
    if (bingoBoards.length == 1) {
      final board = bingoBoards[0];
      if (board.submitNumber(instruction)) {
        return instruction * board.uncheckedSum();
      }
    }

    bingoBoards.removeWhere((e) => e.submitNumber(instruction));
  }

  return 0;
}
