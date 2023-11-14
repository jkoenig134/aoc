enum Direction {
  left,
  right,
  up,
  down;

  static Direction fromString(String s) {
    switch (s) {
      case 'L':
        return Direction.left;
      case 'R':
        return Direction.right;
      case 'U':
        return Direction.up;
      case 'D':
        return Direction.down;
      default:
        throw 'Unknown direction';
    }
  }
}
