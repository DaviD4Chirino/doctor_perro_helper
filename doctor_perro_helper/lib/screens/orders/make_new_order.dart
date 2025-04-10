import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/providers/drafted_order_provider.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/screens/orders/checkout_step.dart';
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
  AsyncValue<UserData> get userDataStream => ref.watch(userDataProvider);

  DraftedOrderNotifier get draftedOrderNotifier =>
      ref.read(draftedOrderNotifierProvider.notifier);

  MenuOrder get menuOrderProvider => ref.watch(draftedOrderNotifierProvider);

  final PageController _pageController = PageController();

  int _index = 0;

  bool get newOrderStepCompleted => menuOrderProvider.length > 0;
  bool editOrderStepCompleted = true;
  bool checkoutStepCompleted = true;

  bool get canAdvance =>
      (index == 0 && newOrderStepCompleted) ||
      (index == 1 && editOrderStepCompleted) ||
      (index == 2 && checkoutStepCompleted);

  MenuOrder order = MenuOrder(plates: [], packs: []);

  set index(int idx) {
    if (idx >= 3) {
      String userId = userDataStream.maybeWhen(
        data: (data) => data.user?.uid ?? "anonymous",
        orElse: () => "anonymous",
      );
      MenuOrder menuOrder = menuOrderProvider..madeBy = userId;

      draftedOrderNotifier.addOrder(menuOrder);
      Navigator.pop(context);
    } else {
      _index = idx.clamp(0, 2);
      _pageController.animateToPage(
        _index,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
      );
    }
  }

  int get index => _index;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onStepContinue() => nextStep();

  void onStepCancel() => setState(() => index -= 1);

  void nextStep() => setState(() => index += 1);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            SizedBox(height: 30),
            stepper(theme),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: FilledButton(
        onPressed: canAdvance
            ? () {
                setState(() => index += 1);
              }
            : null,
        child: Text("Continue"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: Sizes().large,
          right: Sizes().large,
          top: Sizes().xl,
        ),
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            NewOrderStep(),
            EditOrderStep(
              onStepCompleted: (MenuOrder modifiedOrder) {},
            ),
            CheckoutStep(),
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
        lineLength: 45,
        lineSpace: 0,
        progress: 0.5,
        defaultLineColor: theme.colorScheme.onSurface.withAlpha(150),
        finishedLineColor: theme.colorScheme.primary,
        activeLineColor: theme.colorScheme.onSurface,
      ),
      activeStepTextColor: theme.colorScheme.onSurface,
      activeStepIconColor: theme.colorScheme.primary,
      finishedStepTextColor: theme.colorScheme.onSurface,
      defaultStepBorderType: BorderType.normal,
      fitWidth: false,
      stepRadius: 32,
      internalPadding: 5,
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
                title: Text(
                    "Desliza hacia la derecha o izquierda en los platos para agregarlos"),
                subtitle: Text("No has seleccionado ningún plato"),
                dense: true,
              ),
            ),
    );
  }
}
