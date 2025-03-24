import 'package:doctor_perro_helper/models/abstracts/side_dish_list.dart';
import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_quantity.dart';
import 'package:doctor_perro_helper/models/abstracts/ingredients_list.dart';
import 'package:doctor_perro_helper/models/side_dish.dart';
import 'package:uuid/uuid.dart';

/// A class with every single plate in the restaurant
abstract class PlateList {
  /// Compares the plate with their "base" counterpart i.e
  /// the plate in [plates] if theres any and
  /// returns a new [Plate] with only the differences
  static Plate getDifferences(Plate plate) {
    Plate emptyPlate = Plate(
      id: plate.id,
      code: plate.code,
      name: plate.name,
      ingredients: [],
      cost: -99,
      quantity: PlateQuantity(),
    );

    Plate? basePlate = getPlateByCode(plate.code);

    if (basePlate == null) return emptyPlate;

    for (Ingredient ingredient in basePlate.ingredients) {
      if (basePlate.ingredients
              .indexWhere((newIng) => newIng.title == ingredient.title) ==
          -1) {
        emptyPlate.ingredients.add(ingredient);
      }
    }

    // if(basePlate.code )

    return emptyPlate;
  }

  static String get uid => Uuid().v4();

  /// Returns the all the plates with the specified amount
  static List<Plate> platesWithAmount(double amount) {
    return [...plates.map((Plate plate) => plate.amount(amount))];
  }

  static List<PlatePack> packsWithAmount(double amount) {
    return [...packs.map((PlatePack pack) => pack.amount(amount))];
  }

  static List<Plate> platesWithUniqueId() =>
      [...plates.map((Plate p) => p.withUniqueId())];

  static Plate? getExtraByCode(String code) {
    try {
      return extras.firstWhere((extra) => extra.code == code);
    } catch (e) {
      return null;
    }
  }

  static Plate? getPlateByCode(String code) {
    try {
      return plates.firstWhere((plate) => plate.code == code);
    } catch (e) {
      return null;
    }
  }

  static PlatePack? getPackByCode(String code) {
    try {
      return packs.firstWhere((pack) => pack.code == code).copyWith();
    } catch (e) {
      return null;
    }
  }

  static Plate r1 = Plate(
    id: uid,
    code: "R1",
    name: "Perro normal",
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
    cost: 1.5,
    quantity: PlateQuantity(),
  );
  static Plate r2 = Plate(
    id: uid,
    code: "R2",
    name: "Perro Especial",
    ingredients: [
      IngredientsList.sausage,
      IngredientsList.salad,
      IngredientsList.potatoes,
      IngredientsList.tomatoSauce,
      IngredientsList.garlicSauce,
      IngredientsList.bacon, //0.5
      IngredientsList.kraftCheese, //0.5
    ],
    extras: [
      SideDishList.frenchFries, //0.5
    ],
    cost: 1.5,
    quantity: PlateQuantity(),
  );
  static Plate r3 = Plate(
    id: uid,
    code: "R3",
    name: "Hamburguesa",
    ingredients: [
      IngredientsList.patty, //0.8
      IngredientsList.burgerSauce,
      IngredientsList.bacon, //0.5
      IngredientsList.kraftCheese, //0.5
    ],
    extras: [
      SideDishList.frenchFries, //0.5
    ],
    cost: 1.2,
    quantity: PlateQuantity(),
  );
  static Plate r4 = Plate(
    id: uid,
    code: "R4",
    name: "Hamburguesa Doble",
    ingredients: [
      IngredientsList.burgerSauce,
      IngredientsList.patty.amount(2),
      IngredientsList.bacon.amount(2),
      IngredientsList.kraftCheese.amount(2),
    ],
    extras: [
      SideDishList.frenchFries,
    ],
    cost: 1.9,
    quantity: PlateQuantity(),
  );

  static Plate r5 = Plate(
    id: uid,
    code: "R5",
    name: "Salchipapas",
    ingredients: [
      SideDishList.frenchFries.amount(12),
      IngredientsList.bacon.amount(2),
      IngredientsList.corn,
      IngredientsList.kraftCheese,
      IngredientsList.cowCheese,
    ],
    cost: -2.5,
    quantity: PlateQuantity(),
  );

  static PlatePack c1 = PlatePack(
    id: uid,
    code: "C1",
    name: "Combo de Perros",
    plates: [r1.withoutExtras().amount(4)],
    extras: [
      SideDishList.pepsiCola,
      SideDishList.frenchFries.amount(4),
    ],
    cost: -0.5,
    quantity: PlateQuantity(),
  );
  // (1.5 * 4) + 2.5 + (0.5 * 4) = 10.5

  static PlatePack c2 = PlatePack(
    id: uid,
    code: "C2",
    name: "Combo de Perros Especiales",
    plates: [
      r2.withoutExtras().amount(4),
    ],
    extras: [
      SideDishList.pepsiCola,
      SideDishList.frenchFries.amount(4),
    ],
    cost: 0.5,
    quantity: PlateQuantity(),
  );
  // (2.5 * 4)+ (0.5*4) + 2.5 = 14.5
  // Extras
  static Plate e1 = Plate(
    id: uid,
    code: "E1",
    name: "Servicio de Papas Fritas",
    ingredients: [
      SideDishList.frenchFries,
    ],
    cost: 0.0,
    quantity: PlateQuantity(),
  );

  static Plate e2 = Plate(
    id: uid,
    code: "E2",
    name: "Refresco PepsiCola",
    ingredients: [
      SideDishList.pepsiCola,
    ],
    cost: 0.0,
    quantity: PlateQuantity(),
  );

  static List<Plate> plates = [
    r1,
    r2,
    r3,
    r4,
    r5,
  ];
  static List<Plate> extras = [e1, e2];
  static List<PlatePack> packs = [c1, c2];
}
