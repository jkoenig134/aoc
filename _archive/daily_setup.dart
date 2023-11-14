import 'dart:io';

import 'package:http/http.dart' as http;

void main(List<String> args) async {
  final day = args.isNotEmpty ? int.parse(args.last) : DateTime.now().day;
  final dayAsString = day.toString().padLeft(2, "0");

  final codeFilePath = "lib/day$dayAsString.dart";
  final codeFile = File(codeFilePath);
  if (!codeFile.existsSync()) {
    final content = File("_archive/template.dart").readAsStringSync();
    codeFile.writeAsStringSync(content);
  }

  final cookie = File("_archive/cookie.secret").readAsStringSync();
  final response = await http.get(
    Uri.parse('https://adventofcode.com/2015/day/$day/input'),
    headers: {"cookie": cookie},
  );
  String data = response.body;
  data = data.substring(0, data.length - 1);

  File("input/$day.txt").writeAsStringSync(data);

  await Process.run("code", [codeFilePath]);
  await Process.run("code", ["input/$day.txt"]);
}
