import 'dart:ffi';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/utils/extensions/string_capitalize.dart';
import 'package:doctor_perro_helper/widgets/current_dolar_price.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  final List<Plate> plates = [
    Plate(
      code: "R1",
      title: "Perro Normal",
      ingredients: [
        "Ensalada",
        "Papas",
        "Queso de año",
        "Salsa de ajo",
        "Salsa de Tomate",
      ],
      price: 2.0,
    ),
    Plate(
      code: "R2",
      title: "Perro Especial",
      ingredients: [
        "Queso Kraft",
        "Tocino",
        "Ensalada",
        "Papas",
        "Queso de año",
        "Salsa de ajo",
        "Salsa de Tomate",
      ],
      price: 3.0,
    ),
    Plate(
      code: "R3",
      title: "Hamburguesa",
      ingredients: [
        "Carne",
        "Salsa de la casa",
        "Tocino",
        "Queso Kraft",
      ],
      price: 3.5,
    ),
    Plate(
      code: "R4",
      title: "Hamburguesa Doble",
      ingredients: [
        "Doble Carne",
        "Salsa de la casa",
        "Tocino",
        "Queso Kraft",
      ],
      price: 6.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentDate(),
              SizedBox(
                height: Sizes().xxl,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TodaysEarnings(),
                  CurrentDolarPrice(),
                ],
              ),
              SizedBox(
                height: Sizes().xxxl * 2,
              ),
              const Text(
                "Menú",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Sizes().xl,
              ),
              ListView.builder(
                itemBuilder: (context, index) => Text("item Builder $index"),
                itemCount: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Image(
        image: AssetImage("lib/assets/logos/logo_border_transparent.png"),
        width: 60.0,
        height: 60.0,
      ),
      centerTitle: true,
      leading: const Icon(Icons.menu),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Sizes().xxl),
          child: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class Plate {
  Plate({
    required this.code,
    required this.title,
    required this.ingredients,
    required this.price,
  });

  String code;
  String title;
  List<String> ingredients;
  double price;
}

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    super.key,
    required this.plate,
  });
  final Plate plate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: ListTile(
        title: Row(
          children: [
            Text(
              "$plate.code:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              // "Perro Normal",
              plate.title,
              style: const TextStyle(
                fontSize: 10.0,
                letterSpacing: 3.0,
              ),
            ),
          ],
        ),
        subtitle: Text(
          plate.ingredients.join(", "),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
        ),
        // This will become a checkmark when the user taps on it
        leading: const Icon(Icons.fastfood),
        trailing: Text(
          "$plate.price\$",
          style: TextStyle(
              fontSize: 18.0, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}

class CurrentDate extends StatelessWidget {
  CurrentDate({super.key});

  // final DateTime now = DateTime.now();
  final String fullYear = DateFormat.MMMMd("es_ES").format(DateTime.now());
  final String week =
      DateFormat.EEEE("es_ES").format(DateTime.now()).capitalize();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Sizes().xxl),
      child: Text(
        "$week, $fullYear",
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TodaysEarnings extends StatelessWidget {
  const TodaysEarnings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Sizes().xxl),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        // color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "15",
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.green.shade800,
                ),
              ),
              const Text(
                "\$",
                style: TextStyle(
                  fontSize: 24.0,
                  // color: ,
                ),
              )
            ],
          ),
          Text(
            "Ganancias de hoy",
            style: TextStyle(
              fontSize: 12.0,
              color: Theme.of(context).colorScheme.onSurface.withAlpha(170),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
