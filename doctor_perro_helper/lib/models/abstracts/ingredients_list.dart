import 'package:doctor_perro_helper/models/abstracts/side_dish_list.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';

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
    cost: 8.0,
  );
  static Ingredient bacon = Ingredient(
    title: "Tocino",
    cost: 0.5,
  );
  static Ingredient kraftCheese = Ingredient(
    title: "Queso Kraft",
    cost: 0.5,
  );

  static List<Ingredient> get list => [
        salad,
        potatoes,
        tomatoSauce,
        garlicSauce,
        burgerSauce,
        patty,
        bacon,
      ];
}
