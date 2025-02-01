import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/material.dart';

class SurfaceContainer extends StatelessWidget {
  const SurfaceContainer({super.key, required this.child, this.padding});

  final Widget? child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes().roundedSmall),
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      padding: padding,
      child: child,
    );
  }
}
