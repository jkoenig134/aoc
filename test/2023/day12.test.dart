import 'package:aoc/2023/day12.dart';
import 'package:test/test.dart';

void main() {
  final testInput1 = '''???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1''';

  final split = testInput1.split('\n');

  test('allArrangements', () {
    expect(allArrangements(split[0]), 1);
    expect(allArrangements(split[1]), 4);
    expect(allArrangements(split[2]), 1);
    expect(allArrangements(split[3]), 1);
    expect(allArrangements(split[4]), 4);
    expect(allArrangements(split[5]), 10);
  });

  test('part 1', () {
    expect(part1(split), 21);
  });

  test('expand', () {
    expect(expand('.# 1'), '.#?.#?.#?.#?.# 1,1,1,1,1');
    expect(expand('???.### 1,1,3'), '???.###????.###????.###????.###????.### 1,1,3,1,1,3,1,1,3,1,1,3,1,1,3');
  });

  test('part 2', () async {
    expect(part2(split), 525152);
  });
}
