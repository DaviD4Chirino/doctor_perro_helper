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
  static Plate getDifferences(Plate plate) {
    // Find the matching plate in the list
    Plate? matchingPlate = plates.firstWhere(
      (p) => p.code == plate.code,
      orElse: () => Plate(
        id: "",
        code: "",
        name: "",
        ingredients: [],
        cost: 0.0,
        quantity: PlateQuantity(),
      ),
    );

    if (matchingPlate.code == "") {
      // If no matching plate is found, return the original plate
      return plate;
    }

    // Compare the properties and return a new Plate with the differences
    // String? id = plate.id != matchingPlate.id ? plate.id : null;
    String? code = plate.code != matchingPlate.code ? plate.code : null;
    String? name = plate.name != matchingPlate.name ? plate.name : null;
    List<Ingredient>? ingredients;
    if (plate.ingredients.length != matchingPlate.ingredients.length ||
        !plate.ingredients.every(
          (ingredient) => matchingPlate.ingredients
              .any((ing) => ing.name == ingredient.name),
        )) {
      ingredients = plate.ingredients;
    }
    List<SideDish>? extras;
    if ((plate.extras?.length ?? 0) != (matchingPlate.extras?.length ?? 0) ||
        !plate.extras!.every((extra) =>
            matchingPlate.extras!.any((ext) => ext.name == extra.name))) {
      extras = plate.extras;
    }
    double? cost = plate.cost != matchingPlate.cost ? plate.cost : null;
    PlateQuantity? quantity =
        plate.quantity != matchingPlate.quantity ? plate.quantity : null;

    return Plate(
      id: uid,
      code: code ?? matchingPlate.code,
      name: name ?? matchingPlate.name,
      ingredients: ingredients ?? matchingPlate.ingredients,
      extras: extras ?? matchingPlate.extras,
      cost: cost ?? matchingPlate.cost,
      quantity: quantity ?? matchingPlate.quantity,
    );
  }

  static String get uid => Uuid().v4();

  /// Returns the all the plates with the specified amount
  static List<Plate> platesWithAmount(double amount) {
    return [...plates.map((Plate plate) => plate.amount(amount))];
  }

  static List<PlatePack> packsWithAmount(double amount) {
    return [...packs.map((PlatePack pack) => pack.amount(amount))];
  }

  static List<Plate> plateswithUniqueId() =>
      [...plates.map((Plate p) => p.withUniqueId())];

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
      IngredientsList.bacon,
      IngredientsList.corn,
      IngredientsList.kraftCheese,
      IngredientsList.cowCheese,
    ],
    cost: -2,
    quantity: PlateQuantity(),
  );

  static PlatePack c1 = PlatePack(
    id: uid,
    code: "C1",
    name: "Combo de Perros",
    plates: [r1.amount(4).withoutExtras()],
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
    plates: [r2.amount(4).withoutExtras()],
    extras: [
      SideDishList.pepsiCola,
      SideDishList.frenchFries.amount(4),
    ],
    cost: 3.5,
    quantity: PlateQuantity(),
  );
  // (2.5 * 4)+ (0.5*4) + 2.5 = 14.5
  // Extras
  static Plate e1 = Plate(
    id: uid,
    code: "E1",
    name: "Servicio de Papas Fritas",
    ingredients: [
      SideDishList.frenchFries.amount(6),
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
