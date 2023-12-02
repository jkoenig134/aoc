import '/utils/utils.dart';

main(List<String> args) => runSolutions(
      (i) => i.asString().mapL((e) => Elephant.fromString(e)),
      part1,
      part2,
    );

class Elephant {
  String name;

  Elephant(this.name);

  int? value;

  String? fromA;
  String? fromB;

  String? operand;

  bool get isCalculated => value != null;

  bool canBeCalculated(Map<String, Elephant> elephants) => elephants[fromA!]!.isCalculated && elephants[fromB!]!.isCalculated;

  void calculate(Map<String, Elephant> elephants) {
    if (isCalculated) return;
    if (!canBeCalculated(elephants)) return;

    final a = elephants[fromA!]!.value!;
    final b = elephants[fromB!]!.value!;

    switch (operand) {
      case '+':
        value = a + b;
        break;
      case '-':
        value = a - b;
        break;
      case '*':
        value = a * b;
        break;
      case '/':
        value = a ~/ b;
        break;
      default:
        throw Exception('Unknown operand: $operand');
    }
  }

  factory Elephant.fromString(String e) {
    final parts = e.split(': ');

    final elephant = Elephant(parts[0]);

    final parts2 = parts[1].split(' ');

    if (parts2.length == 1) {
      elephant.value = int.parse(parts2[0]);
    } else {
      elephant.fromA = parts2[0];
      elephant.operand = parts2[1];
      elephant.fromB = parts2[2];
    }

    return elephant;
  }
}

int part1(List<Elephant> input) {
  final mapOfElephants = {for (var e in input) e.name: e};
  while (!mapOfElephants['root']!.isCalculated) {
    mapOfElephants.values.forEach((element) {
      element.calculate(mapOfElephants);
    });
  }

  return mapOfElephants['root']!.value!;
}

int part2(List<Elephant> input) {
  return 0;
}
