import 'package:doctor_perro_helper/models/pack_plate.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/abstracts/ingredients_list.dart';

/// A class with every single plate in the restaurant
abstract class PlateList {
  static Plate r1 = Plate(
    code: "R1",
    title: "Perro normal",
    ingredients: [
      IngredientsList.sausage,
      IngredientsList.salad,
      IngredientsList.potatoes,
      IngredientsList.tomatoSauce,
      IngredientsList.garlicSauce,
      IngredientsList.frenchFries,
    ],
    price: 2.0,
    quantity: PlateQuantity(),
  );
  static Plate r2 = Plate(
    code: "R2",
    title: "Perro Especial",
    ingredients: [
      IngredientsList.sausage,
      IngredientsList.salad,
      IngredientsList.potatoes,
      IngredientsList.tomatoSauce,
      IngredientsList.garlicSauce,
      IngredientsList.bacon,
      IngredientsList.kraftCheese,
      IngredientsList.frenchFries,
    ],
    price: 3.0,
    quantity: PlateQuantity(),
  );
  static Plate r3 = Plate(
    code: "R3",
    title: "Hamburguesa",
    ingredients: [
      IngredientsList.patty,
      IngredientsList.burgerSauce,
      IngredientsList.bacon,
      IngredientsList.kraftCheese,
      IngredientsList.frenchFries,
    ],
    price: 3.5,
    quantity: PlateQuantity(),
  );
  static Plate r4 = Plate(
    code: "R4",
    title: "Hamburguesa Doble",
    ingredients: [
      IngredientsList.patty,
      IngredientsList.burgerSauce,
      IngredientsList.bacon,
      IngredientsList.bacon,
      IngredientsList.kraftCheese,
      IngredientsList.frenchFries,
    ],
    price: 3.5,
    quantity: PlateQuantity(),
  );

  static PackPlate c1 = PackPlate(
      code: "C1",
      title: "Combo de Perros",
      plates: [
        r1,
        r1,
        r1,
        r1,
      ],
      price: 10,
      quantity: PlateQuantity());
}
