import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/widgets/current_dolar_price.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
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
              children: [TodaysEarnings(), CurrentDolarPrice()],
            )
          ],
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

class CurrentDate extends StatelessWidget {
  CurrentDate({super.key});

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
              color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
