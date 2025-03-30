import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable_pack.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class SwipeablePlate extends ConsumerStatefulWidget {
  const SwipeablePlate({
    super.key,
    required this.plate,
    required this.onPlateSwiped,
  });

  final Plate plate;

  final void Function(Plate, bool, double)? onPlateSwiped;
  @override
  ConsumerState<SwipeablePlate> createState() => _SwipeablePlateState();
}

class _SwipeablePlateState extends ConsumerState<SwipeablePlate>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  double _count = 0;
  double get count => _count;
  set count(double value) => _count = clampDouble(
      (value), widget.plate.quantity.min, widget.plate.quantity.max);

  late Plate plate;

  @override
  void initState() {
    super.initState();
    plate = widget.plate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Swipeable(
      key: Key(plate.id),
      onSwiped: onSwiped,
      child: SharedListTile(
        count: count,
        plate: plate,
      ),
    );

    /* SwipeableTile.swipeToTrigger(
      direction: SwipeDirection.horizontal,
      key: Key(plate.code),
      borderRadius: Sizes().roundedSmall,
      backgroundBuilder: backgroundBuilder,
      color: theme.colorScheme.surfaceContainer,
      onSwiped: onSwiped,
      child: SharedListTile(
        count: count,
        plate: plate,
      ),
    ); */
  }

  void onSwiped(SwipeDirection direction) {
    if (direction == SwipeDirection.startToEnd) {
      setState(() {
        count -= widget.plate.quantity.count;
      });
      if (widget.onPlateSwiped != null) {
        widget.onPlateSwiped!(plate.amount(count), false, count);
      }
    } else {
      setState(() {
        count += widget.plate.quantity.count;
      });
      if (widget.onPlateSwiped != null) {
        widget.onPlateSwiped!(plate.amount(count), true, count);
      }
    }
  }
}
