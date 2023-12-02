import 'package:aoc/2015/day18.dart';
import 'package:test/test.dart';

void main() {
  final initial = [
    ['.', '#', '.', '#', '.', '#'],
    ['.', '.', '.', '#', '#', '.'],
    ['#', '.', '.', '.', '.', '#'],
    ['.', '.', '#', '.', '.', '.'],
    ['#', '.', '#', '.', '.', '#'],
    ['#', '#', '#', '#', '.', '.'],
  ];

  test('one step', () {
    final result = step(initial);
    result.debugPrint();

    final onLights = result.expand((e) => e).where((e) => e == '#').length;
    expect(onLights, 11);
  });

  test('4 steps', () {
    final result = step(step(step(step(initial))));
    result.debugPrint();

    final onLights = result.expand((e) => e).where((e) => e == '#').length;
    expect(onLights, 4);
  });

  test('1 step corners on', () {
    final result = step(initial, keepCornersOn: true);
    result.debugPrint();

    final onLights = result.expand((e) => e).where((e) => e == '#').length;
    expect(onLights, 18);
  });

  test('4 steps corners on', () {
    final result = step(
      step(
        step(
          step(
            initial,
            keepCornersOn: true,
          ),
          keepCornersOn: true,
        ),
        keepCornersOn: true,
      ),
      keepCornersOn: true,
    );
    result.debugPrint();

    final onLights = result.expand((e) => e).where((e) => e == '#').length;
    expect(onLights, 14);
  });

  test('5 steps corners on', () {
    final result = step(
      step(
        step(
          step(
            step(
              initial,
              keepCornersOn: true,
            ),
            keepCornersOn: true,
          ),
          keepCornersOn: true,
        ),
        keepCornersOn: true,
      ),
      keepCornersOn: true,
    );
    result.debugPrint();

    final onLights = result.expand((e) => e).where((e) => e == '#').length;
    expect(onLights, 17);
  });
}

extension PrintIt on List<List<String>> {
  void debugPrint() {
    print(map((e) => e.join('')).join('\n'));
  }
}
