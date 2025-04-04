import 'dart:ui';

import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/models/plate_pack.dart';
import 'package:doctor_perro_helper/utils/string_math.dart';
import 'package:doctor_perro_helper/widgets/reusables/swipeable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class SwipeablePack extends ConsumerStatefulWidget {
  const SwipeablePack({
    super.key,
    required this.pack,
    this.onPackSwiped,
  });

  final PlatePack pack;
  final void Function(PlatePack, bool, double)? onPackSwiped;

  @override
  ConsumerState<SwipeablePack> createState() => _SwipeablePackState();
}

class _SwipeablePackState extends ConsumerState<SwipeablePack>
    with AutomaticKeepAliveClientMixin {
  double _count = 0;
  double get count => _count;
  set count(double value) => _count =
      clampDouble((value), widget.pack.quantity.min, widget.pack.quantity.max);

  late PlatePack pack;

  @override
  void initState() {
    super.initState();
    pack = widget.pack;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // ThemeData theme = Theme.of(context);

    return Swipeable(
      key: Key(pack.id),
      onSwiped: onSwiped,
      child: SharedListTile(
        pack: pack,
        count: count,
      ),
    );
  }

  void onSwiped(SwipeDirection direction) {
    if (direction == SwipeDirection.startToEnd) {
      setState(() {
        count -= widget.pack.quantity.count;
      });
      if (widget.onPackSwiped != null) {
        widget.onPackSwiped!(pack.amount(count), false, count);
      }
    } else {
      setState(() {
        count += widget.pack.quantity.count;
      });
      if (widget.onPackSwiped != null) {
        widget.onPackSwiped!(pack.amount(count), true, count);
      }
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class SharedListTile extends StatelessWidget {
  const SharedListTile({
    super.key,
    this.pack,
    this.plate,
    required this.count,
  });

  final PlatePack? pack;
  final Plate? plate;
  final double count;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    var code = "${pack?.code ?? ""}${plate?.code ?? ""}";
    var name = "${pack?.name ?? ""}${plate?.name ?? ""}";

    String trailingText =
        "${pack?.quantity.prefix ?? ""}${plate?.quantity.prefix ?? ""}${removePaddingZero(count.toString())}${pack?.quantity.suffix ?? ""}${plate?.quantity.suffix ?? ""}";

    return ListTile(
      leading: Text(
        code,
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pack != null) Text(pack?.plateTitleList as String),
          if (pack != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...pack!.extrasTitleList.map(
                  (String extraTitle) => Text("+ $extraTitle"),
                )
              ],
            ),
          if (plate != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...plate!.extrasTitleList.map(
                  (String extraTitle) => Text("+ $extraTitle"),
                )
              ],
            ),
        ],
      ),
      trailing: Text(
        count > 0 ? trailingText : "",
        style: TextStyle(
          fontSize: theme.textTheme.titleMedium?.fontSize,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
