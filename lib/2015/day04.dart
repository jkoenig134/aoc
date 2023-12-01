import 'dart:convert';

import 'package:crypto/crypto.dart';

import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

int part1(String input) {
  for (var num = 0; num < 100000000; num++) {
    final hash = md5.convert(utf8.encode('$input$num')).toString();
    if (hash.startsWith("00000")) return num;
  }

  return 0;
}

int part2(String input) {
  for (var num = 0; num < 100000000; num++) {
    final hash = md5.convert(utf8.encode('$input$num')).toString();
    if (hash.startsWith("000000")) return num;
  }

  return 0;
}
