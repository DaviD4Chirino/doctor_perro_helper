import 'dart:developer';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add_circle,
          size: 32.0,
        ),
      ),
      body: ListView(
        children: const [
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
    var themeContext = Theme.of(context);
    return SingleChildScrollView(
      child: Section(
        title: Text(
          "Ordenes Pendientes",
          style: TextStyle(
            fontSize: themeContext.textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const ExpansibleOrder(),
      ),
    );
  }
}

class ExpansibleOrder extends StatefulWidget {
  const ExpansibleOrder({super.key});

  @override
  State<ExpansibleOrder> createState() => _ExpansibleOrderState();
}

class _ExpansibleOrderState extends State<ExpansibleOrder> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);

    return GestureDetector(
      onLongPress: () {
        log("Long Pressed");
      },
      child: Column(
        children: [
          ExpansionTile(
            enableFeedback: true,
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            leading: Text(
              "12\$",
              style: TextStyle(
                fontSize: themeContext.textTheme.titleLarge?.fontSize,
              ),
            ),
            title: const Text("30 minutes ago",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("4R1 - E1 - 2R3 - 1R4"),
                Text(
                  "Calle Jabonería Casa 11",
                  style: TextStyle(
                    fontSize: themeContext.textTheme.labelSmall?.fontSize,
                    color: themeContext.colorScheme.onSurface.withAlpha(150),
                  ),
                ),
              ],
            ),
            children: [
              ListTile(
                title: const Text("1R1:"),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: Sizes().xxxl),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "- Poca Mostaza",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "- Sin Queso",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        "+ 150g de Papas",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          FilledButton(
            onPressed: () {},
            child: const Text("Completed"),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            label: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
