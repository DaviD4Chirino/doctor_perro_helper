import 'package:doctor_perro_helper/models/abstracts/side_dish_list.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
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
    ],
    extras: [
      SideDishList.frenchFries,
    ],
    cost: 2.0,
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
    ],
    extras: [
      SideDishList.frenchFries,
    ],
    cost: 3.0,
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
    ],
    extras: [
      SideDishList.frenchFries,
    ],
    cost: 3.5,
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
    ],
    extras: [
      SideDishList.frenchFries,
    ],
    cost: 3.5,
    quantity: PlateQuantity(),
  );

  static Plate r5 = Plate(
    code: "R5",
    title: "Salchipapas",
    ingredients: [
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      IngredientsList.bacon,
      IngredientsList.corn,
      IngredientsList.kraftCheese,
      IngredientsList.cowCheese,
    ],
    cost: 2,
    quantity: PlateQuantity(),
  );

  static PlatePack c1 = PlatePack(
    code: "C1",
    title: "Combo de Perros",
    plates: [
      r1,
      r1,
      r1,
      r1,
    ],
    extras: [
      SideDishList.pepsiCola,
    ],
    price: 10,
    quantity: PlateQuantity(),
  );

  static PlatePack c2 = PlatePack(
    code: "C2",
    title: "Combo de Perros Especiales",
    plates: [
      r2,
      r2,
      r2,
      r2,
    ],
    extras: [
      SideDishList.pepsiCola,
    ],
    price: 10,
    quantity: PlateQuantity(),
  );

  // Extras
  static Plate e1 = Plate(
    code: "E3",
    title: "Servicio de Papas Fritas",
    ingredients: [
      // 300g of FrenchFries
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
      SideDishList.frenchFries,
    ],
    cost: 0.0,
    quantity: PlateQuantity(),
  );

  static List<Plate> list = [
    r1,
    r2,
    r3,
    r4,
    r5,
    e1,
  ];

  static List<PlatePack> listPacks = [c1, c2];
}
