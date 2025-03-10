import 'package:doctor_perro_helper/models/ingredient.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/widgets/reusables/ingredient_list_tile.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class SwipeableIngredientListTile extends StatefulWidget {
  const SwipeableIngredientListTile({
    super.key,
    required this.ingredient,
  });

  final Ingredient ingredient;

  @override
  State<SwipeableIngredientListTile> createState() =>
      _SwipeableIngredientListTileState();
}

class _SwipeableIngredientListTileState
    extends State<SwipeableIngredientListTile> {
  late Ingredient modifiedIngredient;

  double get prevAmount => modifiedIngredient.quantity?.amount ?? 1.0;

  void onSwiped(SwipeDirection dir) {
    if (dir == SwipeDirection.endToStart) {
      setState(() {
        modifiedIngredient = modifiedIngredient.amount(prevAmount + 1);
      });
    }
    if (dir == SwipeDirection.startToEnd) {
      setState(() {
        modifiedIngredient = modifiedIngredient.amount(prevAmount - 1);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    modifiedIngredient = widget.ingredient;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Swipeable(
      key: Key(widget.ingredient.name),
      swipeTileColor: theme.colorScheme.surface,
      onSwiped: onSwiped,
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.bottom,
        horizontalTitleGap: 0,
        dense: true,
        title: IngredientListTile(ingredient: modifiedIngredient),
        // trailing: Text(0.0.removePaddingZero()),
      ),
    );
  }
}
