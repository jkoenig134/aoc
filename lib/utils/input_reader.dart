import 'dart:io';

import 'package:http/http.dart' as http;

class InputReader {
  final int day;
  final int year;

  final String splitPattern;
  late final String _input;

  InputReader(this.day, this.year, [this.splitPattern = '\n']);

  Future<void> init() async {
    final inputFile = File('./input/$year/$day.txt');

    if (inputFile.existsSync()) {
      _input = inputFile.readAsStringSync();
      return;
    }

    inputFile.createSync(recursive: true);

    final cookie = File('_archive/cookie.secret').readAsStringSync();
    final response = await http.get(
      Uri.parse('https://adventofcode.com/$year/day/$day/input'),
      headers: {'cookie': cookie},
    );

    String data = response.body;
    data = data.substring(0, data.length - 1);

    inputFile.writeAsStringSync(data);

    _input = data;
  }

  String raw() => _input;

  List<String> asString() => _input.split(splitPattern);
  List<int> asInt() => asString().map(int.parse).toList();

  List<String> asNewlineString() => _input.split('\n\n').map((e) => e.replaceAll('\n', ' ')).toList();

  List<List<String>> asStringList({firstSplit = '\n', secondSplit = ''}) => _input.split(firstSplit).map((e) => e.split(secondSplit)).toList();

  List<List<int>> asIntList({firstSplit = '\n', secondSplit = ''}) =>
      _input.split(firstSplit).map((e) => e.split(secondSplit).map(int.parse).toList()).toList();
}
