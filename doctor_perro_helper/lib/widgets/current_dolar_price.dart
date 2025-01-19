import 'dart:developer';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';

class CurrentDolarPrice extends StatelessWidget {
  const CurrentDolarPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(Sizes().xxl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes().roundedSmall),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "60",
                    style: TextStyle(
                      fontSize: 60.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const Text(
                    "Bs",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Text(
                "Precio del dolar",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(170),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: Sizes().medium,
          left: Sizes().medium,
          child: Icon(
            Icons.calculate,
            size: Sizes().xxxl,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor:
                  Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(70),
              onTap: () => log("Tapped"),
              borderRadius: BorderRadius.circular(Sizes().roundedSmall),
            ),
          ),
        ),
      ],
    );
  }
}
