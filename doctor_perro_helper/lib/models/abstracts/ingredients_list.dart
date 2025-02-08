import 'package:doctor_perro_helper/models/ingredient.dart';

abstract class IngredientsList {
  static Ingredient sausage = Ingredient(
    name: "Salchicha",
    cost: 0.0,
  );
  static Ingredient salad = Ingredient(
    name: "Ensalada",
    cost: 0.0,
  );
  static Ingredient potatoes = Ingredient(
    name: "Papas",
    cost: 0.0,
  );
  static Ingredient corn = Ingredient(
    name: "Papas",
    cost: 0.0,
  );
  static Ingredient tomatoSauce = Ingredient(
    name: "Salsa de Tomate",
    cost: 0.0,
  );
  static Ingredient garlicSauce = Ingredient(
    name: "Salsa de Ajo",
    cost: 0.0,
  );
  static Ingredient burgerSauce = Ingredient(
    name: "Salsa de Hamburguesa",
    cost: 0.0,
  );
  static Ingredient patty = Ingredient(
    name: "Carne",
    cost: 0.8,
  );
  static Ingredient bacon = Ingredient(
    name: "Tocino",
    cost: 0.5,
  );
  static Ingredient kraftCheese = Ingredient(
    name: "Queso Kraft",
    cost: 0.5,
  );
  static Ingredient cowCheese = Ingredient(
    name: "Queso de Res",
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
