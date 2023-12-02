import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.raw(), part1, part2);

String part1(String input) => increasePassword(input);

String part2(String input) => increasePassword(increasePassword(input));

String increasePassword(String password) {
  do {
    final chars = password.split('');
    for (var i = chars.length - 1; i >= 0; i--) {
      if (chars[i] == 'z') {
        chars[i] = 'a';
      } else {
        chars[i] = String.fromCharCode(chars[i].codeUnitAt(0) + 1);
        break;
      }
    }

    password = chars.join('');
  } while (!isPasswordValid(password));

  return password;
}

bool isPasswordValid(String password) {
  if (password.contains('i') || password.contains('o') || password.contains('l')) return false;

  final twoNonOverlappingPairsRegex = RegExp(r'(\w)\1.*(\w)\2');
  if (!twoNonOverlappingPairsRegex.hasMatch(password)) return false;

  final increasingStraightRegex = RegExp(r'abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz');
  if (!increasingStraightRegex.hasMatch(password)) return false;

  return true;
}
