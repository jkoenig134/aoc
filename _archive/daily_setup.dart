import 'dart:io';

void main(List<String> args) async {
  final day = args.isNotEmpty ? int.parse(args.last) : DateTime.now().day;
  final year = DateTime.now().year;
  final dayAsString = day.toString().padLeft(2, '0');

  final codeFilePath = 'lib/$year/day$dayAsString.dart';
  final codeFile = File(codeFilePath);
  if (!codeFile.existsSync()) {
    final content = File('_archive/template.dart').readAsStringSync();
    codeFile.writeAsStringSync(content);
  }

  await Process.run('code', [codeFilePath]);
}
