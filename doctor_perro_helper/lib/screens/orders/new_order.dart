import 'dart:math';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva orden"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().large,
        ),
        child: Section(
          title: Text(
            "Combos",
            style: TextStyle(
              fontSize: themeContext.textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: SwipeablePlate(),
        ),
      ),
    );
  }
}

class SwipeablePlate extends ConsumerStatefulWidget {
  const SwipeablePlate({
    super.key,
  });

  @override
  ConsumerState<SwipeablePlate> createState() => _SwipeablePlateState();
}

class _SwipeablePlateState extends ConsumerState<SwipeablePlate> {
  int _count = 0;
  int get count => max(0, _count);
  set count(int value) => _count = value;

  @override
  Widget build(BuildContext context) {
    ThemeData themeContext = Theme.of(context);
    return SwipeableTile.swipeToTrigger(
      direction: SwipeDirection.horizontal,
      key: const Key("value"),
      borderRadius: Sizes().roundedSmall,
      backgroundBuilder: (BuildContext context, SwipeDirection direction,
          AnimationController animationController) {
        if (direction == SwipeDirection.startToEnd) {
          return swipeableBackground(
            Colors.red,
            Icons.delete_forever,
            MainAxisAlignment.start,
          );
        }
        return swipeableBackground(
          Colors.green,
          Icons.check_circle_sharp,
          MainAxisAlignment.end,
        );
      },
      color: themeContext.colorScheme.surfaceContainer,
      onSwiped: (SwipeDirection direction) {
        if (direction == SwipeDirection.startToEnd) {
          setState(() {
            count -= 1;
          });
        } else {
          setState(() {
            count += 1;
          });
        }
      },
      child: ListTile(
        leading: Text(
          "C1",
          style: TextStyle(
            fontSize: themeContext.textTheme.titleMedium?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text("4R1 - 1E1"),
        trailing: count < 1
            ? null
            : Text(
                "x$count",
                style: TextStyle(
                  fontSize: themeContext.textTheme.titleMedium?.fontSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
      ),
    );
  }

  Container swipeableBackground(
      Color color, IconData icon, MainAxisAlignment alignment) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Sizes().roundedSmall)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes().xl),
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            Icon(
              icon,
              size: Sizes().iconXl,
            ),
          ],
        ),
      ),
    );
  }
}
