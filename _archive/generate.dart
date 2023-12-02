import 'dart:io';

void main(List<String> args) {
  for (int i = 1; i <= 25; i++) {
    final input = File('input/$i.txt');
    if (!input.existsSync()) input.writeAsString('');
  }
}
