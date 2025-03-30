import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
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
    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);

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
              plate.name,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plate.ingredientsTitles,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              ),
            ),
            ...plate.extrasTitleList.map(
              (title) => Text(
                "+ $title",
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withAlpha(150),
                  fontSize: theme.textTheme.labelSmall?.fontSize,
                ),
              ),
            )
          ],
        ),
        // This will become a checkmark when the user taps on it
        leading: const Icon(Icons.fastfood),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${plate.price.removePaddingZero()}\$",
              style: TextStyle(
                fontSize: theme.textTheme.titleMedium?.fontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              dolarPriceStream.maybeWhen(
                  data: (data) =>
                      "${data.calculate(plate.price).removePaddingZero()}bs",
                  orElse: () => "0bs"),
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

class MenuListItemPack extends ConsumerWidget {
  const MenuListItemPack({
    super.key,
    required this.pack,
  });
  final PlatePack pack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    final AsyncValue<DolarPriceInBsDoc> dolarPriceStream =
        ref.watch(dolarPriceProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: ListTile(
        dense: true,
        title: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5.0,
          runSpacing: 5.0,
          children: [
            Text(
              "${pack.code}:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // "Perro Normal",
              pack.name,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pack.plateTitleList,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withAlpha(150),
              ),
            ),
            // SizedBox(height: 1.0),
            ...pack.extrasTitleList.map(
              (title) => Text(
                "+ $title",
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withAlpha(150),
                  fontSize: theme.textTheme.labelSmall?.fontSize,
                ),
              ),
            )
          ],
        ),
        leading: const Icon(Icons.fastfood),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${removePaddingZero(pack.price.toString())}\$",
              style: TextStyle(
                fontSize: theme.textTheme.titleMedium?.fontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              dolarPriceStream.maybeWhen(
                  data: (data) =>
                      "${data.calculate(pack.price).removePaddingZero()}bs",
                  orElse: () => "0bs"),
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
