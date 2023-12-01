import 'package:aoc/2023/day01.dart';
import 'package:test/test.dart';

void main() {
  test('getCalibration', () {
    expect(getCalibration('1abc2'), 12);
    expect(getCalibration('pqr3stu8vwx'), 38);
    expect(getCalibration('a1b2c3d4e5f'), 15);
    expect(getCalibration('treb7uchet'), 77);
  });

  test('part 1', () {
    expect(part1(['1abc2', 'pqr3stu8vwx', 'a1b2c3d4e5f', 'treb7uchet']), 142);
  });

  test('getCalibrationWithLetters', () {
    expect(getCalibrationWithLetters('two1nine'), 29);
    expect(getCalibrationWithLetters('eightwothree'), 83);
    expect(getCalibrationWithLetters('abcone2threexyz'), 13);
    expect(getCalibrationWithLetters('xtwone3four'), 24);
    expect(getCalibrationWithLetters('4nineeightseven2'), 42);
    expect(getCalibrationWithLetters('zoneight234'), 14);
    expect(getCalibrationWithLetters('7pqrstsixteen'), 76);
  });

  test('part 2', () {});
}
