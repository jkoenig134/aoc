import '/utils/utils.dart';

main(List<String> args) => runSolutions((i) => i.asString(), part1, part2);

class Ingredient {
  final int capacity;
  final int durability;
  final int flavor;
  final int texture;
  final int calories;

  Ingredient(
    this.capacity,
    this.durability,
    this.flavor,
    this.texture,
    this.calories,
  );

  factory Ingredient.fromString(String input) {
    final regex = RegExp(
      r'\w+: capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)',
    );

    final match = regex.firstMatch(input)!;
    return Ingredient(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
      int.parse(match.group(4)!),
      int.parse(match.group(5)!),
    );
  }
}

int part1(List<String> input) {
  final ingredients = input.map(Ingredient.fromString).toList();

  var highestScore = 0;

  for (var i = 0; i <= 100; i++) {
    for (var j = 0; j <= 100 - i; j++) {
      for (var k = 0; k <= 100 - i - j; k++) {
        final l = 100 - i - j - k;

        final score = mixIngredients([
          (ingredient: ingredients[0], teaspoons: i),
          (ingredient: ingredients[1], teaspoons: j),
          (ingredient: ingredients[2], teaspoons: k),
          (ingredient: ingredients[3], teaspoons: l),
        ]);

        if (score > highestScore) {
          highestScore = score;
        }
      }
    }
  }

  return highestScore;
}

int mixIngredients(List<({Ingredient ingredient, int teaspoons})> ingredients) {
  final capacity = ingredients.map((i) => i.ingredient.capacity * i.teaspoons).sumOnlyPositive;

  final durability = ingredients.map((i) => i.ingredient.durability * i.teaspoons).sumOnlyPositive;

  final flavor = ingredients.map((i) => i.ingredient.flavor * i.teaspoons).sumOnlyPositive;

  final texture = ingredients.map((i) => i.ingredient.texture * i.teaspoons).sumOnlyPositive;

  return capacity * durability * flavor * texture;
}

int part2(List<String> input) {
  final ingredients = input.map(Ingredient.fromString).toList();

  var highestScore = 0;

  for (var i = 0; i <= 100; i++) {
    for (var j = 0; j <= 100 - i; j++) {
      for (var k = 0; k <= 100 - i - j; k++) {
        final l = 100 - i - j - k;

        final score = mixIngredients([
          (ingredient: ingredients[0], teaspoons: i),
          (ingredient: ingredients[1], teaspoons: j),
          (ingredient: ingredients[2], teaspoons: k),
          (ingredient: ingredients[3], teaspoons: l),
        ]);

        final calories = [
          ingredients[0].calories * i,
          ingredients[1].calories * j,
          ingredients[2].calories * k,
          ingredients[3].calories * l,
        ].sumOnlyPositive;

        if (score > highestScore && calories == 500) {
          highestScore = score;
        }
      }
    }
  }

  return highestScore;
}
