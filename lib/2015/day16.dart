import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

class Sue {
  final int number;

  final int? children;
  final int? cats;
  final int? samoyeds;
  final int? pomeranians;
  final int? akitas;
  final int? vizslas;
  final int? goldfish;
  final int? trees;
  final int? cars;
  final int? perfumes;

  Sue(
    this.number, {
    required this.children,
    required this.cats,
    required this.samoyeds,
    required this.pomeranians,
    required this.akitas,
    required this.vizslas,
    required this.goldfish,
    required this.trees,
    required this.cars,
    required this.perfumes,
  });

  factory Sue.fromString(String input) {
    final number =
        int.parse(RegExp(r'Sue (\d+):').firstMatch(input)!.group(1)!);

    final children =
        RegExp(r'children: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final cats = RegExp(r'cats: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final samoyeds =
        RegExp(r'samoyeds: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final pomeranians =
        RegExp(r'pomeranians: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final akitas = RegExp(r'akitas: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final vizslas =
        RegExp(r'vizslas: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final goldfish =
        RegExp(r'goldfish: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final trees = RegExp(r'trees: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final cars = RegExp(r'cars: (\d+)').firstMatch(input)?.group(1)!.asInt;
    final perfumes =
        RegExp(r'perfumes: (\d+)').firstMatch(input)?.group(1)!.asInt;

    return Sue(
      number,
      children: children,
      cats: cats,
      samoyeds: samoyeds,
      pomeranians: pomeranians,
      akitas: akitas,
      vizslas: vizslas,
      goldfish: goldfish,
      trees: trees,
      cars: cars,
      perfumes: perfumes,
    );
  }
}

int part1(List<String> input) {
  final sues = input.map(Sue.fromString).toList();
  sues.removeWhere((s) => s.children != null && s.children != 3);
  sues.removeWhere((s) => s.cats != null && s.cats != 7);
  sues.removeWhere((s) => s.samoyeds != null && s.samoyeds != 2);
  sues.removeWhere((s) => s.pomeranians != null && s.pomeranians != 3);
  sues.removeWhere((s) => s.akitas != null && s.akitas != 0);
  sues.removeWhere((s) => s.vizslas != null && s.vizslas != 0);
  sues.removeWhere((s) => s.goldfish != null && s.goldfish != 5);
  sues.removeWhere((s) => s.trees != null && s.trees != 3);
  sues.removeWhere((s) => s.cars != null && s.cars != 2);
  sues.removeWhere((s) => s.perfumes != null && s.perfumes != 1);

  return sues.first.number;
}

int part2(List<String> input) {
  final sues = input.map(Sue.fromString).toList();
  sues.removeWhere((s) => s.children != null && s.children != 3);
  sues.removeWhere((s) => s.cats != null && s.cats! <= 7);
  sues.removeWhere((s) => s.samoyeds != null && s.samoyeds != 2);
  sues.removeWhere((s) => s.pomeranians != null && s.pomeranians! >= 3);
  sues.removeWhere((s) => s.akitas != null && s.akitas != 0);
  sues.removeWhere((s) => s.vizslas != null && s.vizslas != 0);
  sues.removeWhere((s) => s.goldfish != null && s.goldfish! >= 5);
  sues.removeWhere((s) => s.trees != null && s.trees! <= 3);
  sues.removeWhere((s) => s.cars != null && s.cars != 2);
  sues.removeWhere((s) => s.perfumes != null && s.perfumes != 1);

  return sues.first.number;
}
