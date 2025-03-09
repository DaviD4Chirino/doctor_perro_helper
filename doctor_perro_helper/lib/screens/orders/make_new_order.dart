import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/screens/orders/edit_order_step.dart';
import 'package:doctor_perro_helper/screens/orders/new_order_step.dart';
import 'package:doctor_perro_helper/widgets/orders/drafted_order.dart';
import 'package:doctor_perro_helper/widgets/reusables/Section.dart';
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
        NewOrderStep(
          onStepCompleted: onNewOrderStepCompleted,
        ),
        EditOrderStep(),
        Center(child: Text("Page 3")),
      ];
  int _index = 0;

  bool newOrderStepCompleted = false;
  bool editOrderStepCompleted = true;

  bool get canAdvance =>
      index == 0 && newOrderStepCompleted ||
      index == 1 && editOrderStepCompleted;

  MenuOrder order = MenuOrder(plates: [], packs: []);

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

  void onStepContinue() => setState(() => index += 1);

  void onStepCancel() => setState(() => index -= 1);

  void nextStep() => setState(() => index += 1);

  void onNewOrderStepCompleted(bool completed) {
    setState(() {
      newOrderStepCompleted = completed;
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
        onPressed: canAdvance ? nextStep : null,
        child: Text("Continue"),
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes().xl),
        child: Column(
          children: [
            stepper(theme),
            // draftedOrderSection(columnTitleStyle, theme),
            /* Container(
              height: 1,
              color: theme.colorScheme.outline,
            ), */
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: steps,
              ),
            )
          ],
        ),
      ),
    );
  }

  EasyStepper stepper(ThemeData theme) {
    return EasyStepper(
      padding: EdgeInsets.all(0),
      activeStep: index,
      lineStyle: LineStyle(
        lineType: LineType.normal,
        lineLength: 70,
        lineSpace: 0,
        defaultLineColor: theme.colorScheme.onSurface.withAlpha(150),
        finishedLineColor: theme.colorScheme.primary,
        activeLineColor: theme.colorScheme.onSurface,
      ),
      activeStepTextColor: theme.colorScheme.onSurface,
      activeStepIconColor: theme.colorScheme.primary,

      // activeStepBackgroundColor: theme.colorScheme.onSurface,
      finishedStepTextColor: theme.colorScheme.primary,
      defaultStepBorderType: BorderType.normal,
      fitWidth: false,
      stepRadius: 32,
      internalPadding: 18,
      showTitle: true,
      showLoadingAnimation: false,

      steps: [
        EasyStep(
          enabled: index > 0,
          topTitle: false,
          title: "Crear",
          icon: Icon(Icons.add),
        ),
        EasyStep(
          enabled: index > 1,
          topTitle: false,
          title: "Editar",
          icon: Icon(Icons.edit_note_sharp),
        ),
        EasyStep(
          enabled: index > 2,
          topTitle: false,
          title: "Revisar",
          icon: Icon(Icons.checklist_outlined),
        )
      ],
      onStepReached: (int idx) => setState(() => index = idx),
    );
  }

  Section draftedOrderSection(TextStyle columnTitleStyle, ThemeData theme) {
    return Section(
      title: Text(
        "Orden Seleccionada:",
        style: columnTitleStyle,
      ),
      child: order.length > 0
          ? DraftedOrder(order: order)
          : Container(
              color: theme.colorScheme.surfaceContainer,
              child: ListTile(
                // enabled: false,
                title: Text(
                    "Desliza hacia la derecha o izquierda en los platos para agregarlos"),
                subtitle: Text("No has seleccionado ningún plato"),
                dense: true,
              ),
            ),
    );
  }
}
