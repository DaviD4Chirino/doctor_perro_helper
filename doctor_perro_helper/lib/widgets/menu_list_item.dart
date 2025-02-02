import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';

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
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      child: ListTile(
        dense: true,
        title: Row(
          children: [
            Text(
              "${plate.code}:",
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
          "${removePaddingZero(plate.price.toString())}\$",
          style: TextStyle(
            fontSize: 18.0,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
