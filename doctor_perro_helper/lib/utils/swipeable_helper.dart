import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

Widget backgroundBuilder(
  BuildContext context,
  SwipeDirection direction,
  AnimationController animationController,
) {
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
