import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class Swipeable extends StatelessWidget {
  const Swipeable({
    super.key,
    required this.child,
    required this.onSwiped,
    this.backgroundBuilder,
    this.swipeTileColor,
    this.direction = SwipeDirection.horizontal,
    this.backgroundStartIcon = Icons.check_circle_sharp,
    this.backgroundEndIcon = Icons.delete_forever,
    this.backgroundEndColor = Colors.red,
    this.backgroundStartColor = Colors.green,
  });

  final Widget child;
  final void Function(SwipeDirection swipeDirection) onSwiped;
  final Widget Function(
    BuildContext context,
    SwipeDirection direction,
    AnimationController animationController,
  )? backgroundBuilder;
  final Color? swipeTileColor;

  /// In the reading direction (e.g., from left to right in left-to-right languages).
  final SwipeDirection direction;

  /// In the reading direction (e.g., from left to right in left-to-right languages).
  final IconData backgroundStartIcon;

  /// In the reading direction (e.g., from left to right in left-to-right languages).
  final Color backgroundStartColor;

  /// In the reading direction (e.g., from left to right in left-to-right languages).
  final IconData backgroundEndIcon;

  /// In the reading direction (e.g., from left to right in left-to-right languages).
  final Color backgroundEndColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SwipeableTile.swipeToTrigger(
      key: key ?? Key("No key Provided"),
      backgroundBuilder: backgroundBuilder ?? _backgroundBuilder,
      color: swipeTileColor ?? theme.colorScheme.surfaceContainer,
      onSwiped: onSwiped,
      direction: direction,
      child: child,
    );
  }

  Widget _backgroundBuilder(
    BuildContext context,
    SwipeDirection direction,
    AnimationController animationController,
  ) {
    if (direction == SwipeDirection.startToEnd) {
      return swipeableBackground(
        backgroundEndColor,
        backgroundEndIcon,
        MainAxisAlignment.start,
      );
    }
    return swipeableBackground(
      backgroundStartColor,
      backgroundStartIcon,
      MainAxisAlignment.end,
    );
  }

  Container swipeableBackground(
    Color color,
    IconData icon,
    MainAxisAlignment alignment,
  ) {
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
