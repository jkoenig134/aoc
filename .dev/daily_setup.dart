import 'dart:io';

void main(List<String> args) async {
  final day = args.isNotEmpty ? int.parse(args.last) : DateTime.now().day;
  final year = DateTime.now().year;
  final dayAsString = day.toString().padLeft(2, '0');

  final codeFilePath = 'lib/$year/day$dayAsString.dart';
  final codeFile = File(codeFilePath);
  if (!codeFile.existsSync()) {
    final content = File('.dev/template.dart').readAsStringSync();
    codeFile.writeAsStringSync(content);
  }

  final testFilePath = 'test/$year/day$dayAsString.test.dart';
  final testFile = File(testFilePath);
  if (!testFile.existsSync()) {
    final content = File('.dev/template.test.dart').readAsStringSync();
    testFile.writeAsStringSync(content.replaceAll('%year%', year.toString()).replaceAll('%day%', dayAsString));
  }

  await Future.wait([
    Process.run('open', ['https://adventofcode.com/$year/day/$day']),
    Process.run('code', [testFilePath]),
    Process.run('code', [codeFilePath]),
  ]);
}
