import 'dart:math';
import 'dart:ui';

import 'package:doctor_perro_helper/screens/orders/new_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_stepper/easy_stepper.dart';

class MakeNewOrder extends ConsumerStatefulWidget {
  const MakeNewOrder({super.key});

  @override
  ConsumerState<MakeNewOrder> createState() => _MakeNewOrderState();
}

class _MakeNewOrderState extends ConsumerState<MakeNewOrder> {
  late PageController? _pageController;
  List<Widget> get steps => [
        Center(child: Text("Page 1")),
        Center(child: Text("Page 2")),
        Center(child: Text("Page 3")),
      ];
  int _index = 0;

  set index(int idx) {
    _index = idx.clamp(0, steps.length - 1);
    _pageController!.animateToPage(
      _index,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
    );
  }

  int get index => _index;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  onStepContinue() {
    setState(() {
      index += 1;
    });
  }

  onStepCancel() {
    setState(() {
      index -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo Pedido"),
      ),
      bottomNavigationBar: FilledButton(
        onPressed: () {
          setState(() {
            index += 1;
          });
        },
        child: Text("Continue"),
      ),
      body: Column(
        children: [
          stepper(theme),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: steps,
            ),
          )
        ],
      ),
    );
  }

  EasyStepper stepper(ThemeData theme) {
    return EasyStepper(
      activeStep: index,
      lineStyle: LineStyle(
        lineType: LineType.normal,
        lineLength: 70,
        lineSpace: 0,
      ),
      activeStepTextColor: theme.colorScheme.onSurface,
      activeStepIconColor: theme.colorScheme.primary,
      // activeStepBackgroundColor: theme.colorScheme.onSurface,
      finishedStepTextColor: theme.colorScheme.primary,
      defaultStepBorderType: BorderType.normal,
      fitWidth: true,
      stepRadius: 36,
      showTitle: true,
      showLoadingAnimation: false,

      steps: [
        EasyStep(
          enabled: index > 0,
          topTitle: false,
          title: "Creación",
          icon: Icon(Icons.food_bank),
        ),
        EasyStep(
          enabled: index > 1,
          topTitle: false,
          title: "Creación",
          icon: Icon(Icons.food_bank),
        ),
        EasyStep(
          enabled: index > 2,
          topTitle: false,
          title: "Revisión",
          icon: Icon(Icons.food_bank),
        )
      ],
      onStepReached: (int idx) => setState(() => index = idx),
    );
  }
}
