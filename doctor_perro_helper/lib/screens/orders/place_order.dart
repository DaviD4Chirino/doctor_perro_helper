import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva orden"),
      ),
      body: ListView(
        children: [
          OrdenesPendientes(),
        ],
      ),
    );
  }
}

class OrdenesPendientes extends StatelessWidget {
  const OrdenesPendientes({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: Text(
        "Ordenes Pendientes",
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Text(
          "12\$",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
          ),
        ),
        /* IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
          padding: EdgeInsets.all(0.0),
          visualDensity: VisualDensity.compact,
        ), */
      ],
      child: ListTile(
        title: Text(
          "R1",
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
