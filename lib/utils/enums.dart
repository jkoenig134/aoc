enum Direction {
  left,
  right,
  up,
  down;

  static Direction fromString(String s) => switch (s) {
        'L' => Direction.left,
        'R' => Direction.right,
        'U' => Direction.up,
        'D' => Direction.down,
        _ => throw 'Unknown direction',
      };

  static Direction fromCarets(String s) => switch (s) {
        '<' => Direction.left,
        '>' => Direction.right,
        '^' => Direction.up,
        'v' => Direction.down,
        _ => throw 'Unknown direction',
      };

  String asCaret() => switch (this) { Direction.left => '<', Direction.right => '>', Direction.up => '^', Direction.down => 'v' };
}
