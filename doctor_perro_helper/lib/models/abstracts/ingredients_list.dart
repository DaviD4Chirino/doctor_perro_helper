import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';

abstract class IngredientsList {
  static Ingredient sausage = Ingredient(
    name: "Salchicha",
    cost: 0.0,
    minName: "Sin Salchicha",
    quantity: PlateQuantity(),
    quantifiable: false,
  );
  static Ingredient salad = Ingredient(
    name: "Ensalada",
    cost: 0.0,
    quantity: PlateQuantity(
      max: 2,
    ),
    maxName: "Extra Ensalada",
    minName: "Sin Ensalada",
    quantifiable: false,
  );
  static Ingredient potatoes = Ingredient(
    name: "Papas",
    cost: 0.0,
    minName: "Sin Papas",
    quantity: PlateQuantity(
      max: 2,
    ),
    quantifiable: false,
  );
  static Ingredient corn = Ingredient(
    name: "Maíz",
    cost: 0.0,
    minName: "Sin Maíz",
    maxName: "Maíz Extra",
    quantity: PlateQuantity(
      max: 2,
    ),
    quantifiable: false,
  );
  static Ingredient tomatoSauce = Ingredient(
    name: "Salsa de Tomate",
    cost: 0.0,
    minName: "Sin Salsa de Tomate",
    maxName: "Salsa de Tomate Extra",
    quantity: PlateQuantity(
      max: 2,
    ),
    quantifiable: false,
  );
  static Ingredient garlicSauce = Ingredient(
    name: "Salsa de Ajo",
    cost: 0.0,
    minName: "Sin Salsa de Ajo",
    maxName: "Salsa de Ajo Extra",
    quantity: PlateQuantity(
      max: 2,
    ),
    quantifiable: false,
  );
  static Ingredient burgerSauce = Ingredient(
    name: "Salsa de Hamburguesa",
    cost: 0.0,
    minName: "Sin Salsa de Hamburguesa",
    maxName: "Salsa de Hamburguesa Extra",
    quantity: PlateQuantity(
      max: 2,
    ),
    quantifiable: false,
  );
  static Ingredient patty = Ingredient(
    name: "Carne",
    cost: 0.8,
    minName: "Sin Carne",
    quantity: PlateQuantity(),
  );
  static Ingredient bacon = Ingredient(
    name: "Tocino",
    cost: 0.5,
    quantity: PlateQuantity(),
    minName: "Sin Tocino",
  );
  static Ingredient kraftCheese = Ingredient(
    name: "Queso Kraft",
    cost: 0.5,
    quantity: PlateQuantity(),
    minName: "Sin Queso Kraft",
  );
  static Ingredient cowCheese = Ingredient(
    name: "Queso de Res",
    cost: 0.0,
    minName: "Sin Queso de Res",
    maxName: "Queso de Res Extra",
    quantity: PlateQuantity(
      max: 2,
    ),
    quantifiable: false,
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
