import 'package:aoc2015/day12.dart';
import 'package:test/test.dart';

void main() {
  test("json sum", () {
    expect(jsonSum("[1,2,3]"), 6);
    expect(jsonSum('{"a":2,"b":4}'), 6);
    expect(jsonSum("[[[3]]]"), 3);
    expect(jsonSum('{"a":{"b":4},"c":-1}'), 3);
    expect(jsonSum('{"a":[-1,1]}'), 0);
    expect(jsonSum('[-1,{"a":1}]'), 0);
    expect(jsonSum('[]'), 0);
    expect(jsonSum('{}'), 0);
  });

  test("json sum (red ignored)", () {
    expect(jsonSum("[1,2,3]", ignoreRed: true), 6);
    expect(jsonSum('[1,{"c":"red","b":2},3]', ignoreRed: true), 4);
    expect(jsonSum('{"d":"red","e":[1,2,3,4],"f":5}', ignoreRed: true), 0);
    expect(
      jsonSum(
        '{"asd": {"d":"red","e":[1,2,3,4],"f":5}, "a":5}',
        ignoreRed: true,
      ),
      5,
    );
    expect(jsonSum('[1,"red",5]', ignoreRed: true), 6);
  });
}
