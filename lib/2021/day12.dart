import '/utils/utils.dart';

class Point {
  final String name;

  Point(this.name);
}

class Graph {
  late int numberOfVertices;
  final Map<String, List<String>> neighbours = {};

  Graph(this.numberOfVertices);

  Graph.fromInput(List<String> input) {
    final entries = input.map((e) => e.split("-"));

    final uniquePoints = entries.expand((element) => element).toSet();
    numberOfVertices = uniquePoints.length;

    entries.forEach((e) => addEdge(e[0], e[1]));
  }

  void addEdge(String u, String v) {
    (neighbours[u] ??= []).add(v);
    (neighbours[v] ??= []).add(u);
  }

  List<List<String>> getAllPaths(String start, String end, bool p2) =>
      _calculatePaths(start, end, [start], p2, false);

  List<List<String>> _calculatePaths(
    String currentNode,
    String end,
    List<String> currentPath,
    bool twoSmallCavesAllowed,
    bool enteredSmallCaveTwice,
  ) {
    if (currentNode == end) {
      return [List.from(currentPath)];
    }

    final paths = <List<String>>[];

    for (String n in neighbours[currentNode] ?? []) {
      final smallDuplicate = currentPath.contains(n) && n.toLowerCase() == n;

      if ((n == "start") ||
          (smallDuplicate && !twoSmallCavesAllowed) ||
          (smallDuplicate && enteredSmallCaveTwice)) {
        continue;
      }

      currentPath.add(n);
      paths.addAll(_calculatePaths(
        n,
        end,
        currentPath,
        twoSmallCavesAllowed,
        enteredSmallCaveTwice || smallDuplicate,
      ));
      currentPath.removeLast();
    }

    return paths;
  }
}

main(List<String> args) =>
    runSolutions((i) => Graph.fromInput(i.asString()), part1, part2);

int part1(Graph graph) => graph.getAllPaths("start", "end", false).length;

int part2(Graph graph) => graph.getAllPaths("start", "end", true).length;
