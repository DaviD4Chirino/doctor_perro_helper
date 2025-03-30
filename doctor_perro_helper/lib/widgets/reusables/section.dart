import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';

Sizes sizes = Sizes();

class Section extends StatelessWidget {
  const Section({super.key, required this.child, this.title, this.actions});

  final Widget child;
  final Widget? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          // left: sizes.large,
          // right: sizes.large,
          bottom: sizes.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisSize: MainAxisSize.max,

        // mainAxisAlignment: MainAxisAlignment.end,
        textBaseline: TextBaseline.alphabetic,
        spacing: sizes.large,
        children: [
          Row(
            textBaseline: TextBaseline.alphabetic,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            spacing: sizes.medium,
            children: [
              if (title != null)
                Expanded(
                  child: title as Widget,
                ),
              ...?actions,
            ],
          ),
          child,
        ],
      ),
    );
  }
}
