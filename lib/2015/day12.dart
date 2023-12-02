import 'dart:convert';

import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

int part1(String input) => jsonSum(input);

int part2(String input) => jsonSum(input, ignoreRed: true);

int jsonSum(String json, {bool ignoreRed = false}) => _sumJson(jsonDecode(json), ignoreRed);

int _sumJson(dynamic json, bool ignoreRed) {
  if (json is int) return json;

  if (json is List) {
    return json.map((v) => _sumJson(v, ignoreRed)).fold(0, (a, b) => a + b);
  }

  if (json is Map) {
    if (ignoreRed && json.values.contains('red')) return 0;
    return json.values.map((v) => _sumJson(v, ignoreRed)).fold(0, (a, b) => a + b);
  }

  return 0;
}
