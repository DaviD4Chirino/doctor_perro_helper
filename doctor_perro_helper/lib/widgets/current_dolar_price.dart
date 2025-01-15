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
          child: Row(
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
        ),
        Positioned(
          top: Sizes().medium,
          left: Sizes().medium,
          child: Icon(
            Icons.monetization_on,
            size: Sizes().xxxl,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
          ),
        )
      ],
    );
  }
}
