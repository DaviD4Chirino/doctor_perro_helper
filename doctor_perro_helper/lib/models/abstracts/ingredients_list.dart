import 'package:doctor_perro_helper/models/ingredient.dart';

abstract class IngredientsList {
  static Ingredient sausage = Ingredient(
    title: "Salchicha",
    cost: 0.0,
  );
  static Ingredient salad = Ingredient(
    title: "Ensalada",
    cost: 0.0,
  );
  static Ingredient potatoes = Ingredient(
    title: "Papas",
    cost: 0.0,
  );
  static Ingredient corn = Ingredient(
    title: "Papas",
    cost: 0.0,
  );
  static Ingredient tomatoSauce = Ingredient(
    title: "Salsa de Tomate",
    cost: 0.0,
  );
  static Ingredient garlicSauce = Ingredient(
    title: "Salsa de Ajo",
    cost: 0.0,
  );
  static Ingredient burgerSauce = Ingredient(
    title: "Salsa de Hamburguesa",
    cost: 0.0,
  );
  static Ingredient patty = Ingredient(
    title: "Carne",
    cost: 0.8,
  );
  static Ingredient bacon = Ingredient(
    title: "Tocino",
    cost: 0.5,
  );
  static Ingredient kraftCheese = Ingredient(
    title: "Queso Kraft",
    cost: 0.5,
  );
  static Ingredient cowCheese = Ingredient(
    title: "Queso de Res",
    cost: 0.0,
  );

  static List<Ingredient> get list => [
        sausage,
        salad,
        potatoes,
        corn,
        tomatoSauce,
        garlicSauce,
        burgerSauce,
        patty,
        bacon,
        kraftCheese,
        cowCheese,
      ];
}
