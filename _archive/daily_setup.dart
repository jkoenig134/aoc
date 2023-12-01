import 'dart:io';

import 'package:http/http.dart' as http;

void main(List<String> args) async {
  final day = args.isNotEmpty ? int.parse(args.last) : DateTime.now().day;
  final year = DateTime.now().year;
  final dayAsString = day.toString().padLeft(2, "0");

  final codeFilePath = "lib/$year/day$dayAsString.dart";
  final codeFile = File(codeFilePath);
  if (!codeFile.existsSync()) {
    final content = File("_archive/template.dart").readAsStringSync();
    codeFile.writeAsStringSync(content);
  }

  final cookie = File("_archive/cookie.secret").readAsStringSync();
  final response = await http.get(
    Uri.parse('https://adventofcode.com/$year/day/$day/input'),
    headers: {"cookie": cookie},
  );
  String data = response.body;
  data = data.substring(0, data.length - 1);

  File("input/$year/$day.txt").writeAsStringSync(data);

  await Process.run("code", [codeFilePath]);
  await Process.run("code", ["input/$year/$day.txt"]);
}
