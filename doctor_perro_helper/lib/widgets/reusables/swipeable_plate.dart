import 'dart:math';

import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class SwipeablePlate extends ConsumerStatefulWidget {
  const SwipeablePlate({
    super.key,
    required this.plate,
  });

  final Plate plate;

  @override
  ConsumerState<SwipeablePlate> createState() => _SwipeablePlateState();
}

class _SwipeablePlateState extends ConsumerState<SwipeablePlate> {
  int _count = 0;
  int get count => max(0, _count);
  set count(int value) => _count = value;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SwipeableTile.swipeToTrigger(
      direction: SwipeDirection.horizontal,
      key: Key(widget.plate.code),
      borderRadius: Sizes().roundedSmall,
      backgroundBuilder: backgroundBuilder,
      color: theme.colorScheme.surfaceContainer,
      onSwiped: onSwiped,
      child: ListTile(
        leading: Text(
          widget.plate.code,
          style: TextStyle(
            fontSize: theme.textTheme.titleMedium?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(widget.plate.title),
        subtitle: widget.plate.extras == null
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.plate.extrasTitleList.map(
                    (String extraTitle) => Text("+ $extraTitle"),
                  )
                ],
              ),
        trailing: count < 1
            ? null
            : Text(
                "x$count",
                style: TextStyle(
                  fontSize: theme.textTheme.titleMedium?.fontSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
      ),
    );
  }

  void onSwiped(SwipeDirection direction) {
    if (direction == SwipeDirection.startToEnd) {
      setState(() {
        count -= 1;
      });
    } else {
      setState(() {
        count += 1;
      });
    }
  }
}

class SwipeablePack extends ConsumerStatefulWidget {
  const SwipeablePack({
    super.key,
    required this.pack,
  });

  final PlatePack pack;

  @override
  ConsumerState<SwipeablePack> createState() => _SwipeablePackState();
}

class _SwipeablePackState extends ConsumerState<SwipeablePack> {
  int _count = 0;
  int get count => max(0, _count);
  set count(int value) => _count = value;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SwipeableTile.swipeToTrigger(
      direction: SwipeDirection.horizontal,
      key: Key(widget.pack.code),
      borderRadius: Sizes().roundedSmall,
      backgroundBuilder: backgroundBuilder,
      color: theme.colorScheme.surfaceContainer,
      onSwiped: onSwiped,
      child: ListTile(
        leading: Text(
          widget.pack.code,
          style: TextStyle(
            fontSize: theme.textTheme.titleMedium?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(widget.pack.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.pack.plateTitleList),
            if (widget.pack.extras != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.pack.extrasTitleList.map(
                    (String extraTitle) => Text("+ $extraTitle"),
                  )
                ],
              ),
          ],
        ),
        trailing: count < 1
            ? null
            : Text(
                "x$count",
                style: TextStyle(
                  fontSize: theme.textTheme.titleMedium?.fontSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
      ),
    );
  }

  void onSwiped(SwipeDirection direction) {
    if (direction == SwipeDirection.startToEnd) {
      setState(() {
        count -= 1;
      });
    } else {
      setState(() {
        count += 1;
      });
    }
  }
}

Widget backgroundBuilder(BuildContext context, SwipeDirection direction,
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
