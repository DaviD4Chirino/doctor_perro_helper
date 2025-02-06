import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/providers/settings.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuListItem extends ConsumerWidget {
  const MenuListItem({
    super.key,
    required this.plate,
  });
  final Plate plate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        color: Theme.of(context).colorScheme.surfaceContainer,
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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${removePaddingZero(plate.cost.toString())}\$",
              style: TextStyle(
                fontSize: theme.textTheme.titleMedium?.fontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              "${removePaddingZero(ref.read(dolarPriceNotifierProvider.notifier).calculate(plate.cost).toString())}bs",
              style: TextStyle(
                fontSize: theme.textTheme.labelSmall?.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
