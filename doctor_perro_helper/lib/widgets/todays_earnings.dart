import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';

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
                  color: Theme.of(context).hintColor,
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
