import 'package:aoc2015/day15.dart';
import 'package:test/test.dart';

void main() {
  final butterscotch = Ingredient.fromString(
    "Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8",
  );
  final cinnamon = Ingredient.fromString(
    "Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3",
  );

  test("mix ingredients", () {
    expect(
      mixIngredients([
        (ingredient: butterscotch, teaspoons: 44),
        (ingredient: cinnamon, teaspoons: 56),
      ]),
      62842880,
    );
  });
}
