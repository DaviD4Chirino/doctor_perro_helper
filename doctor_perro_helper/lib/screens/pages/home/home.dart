import 'package:doctor_perro_helper/screens/dash_board.dart';
import 'package:doctor_perro_helper/screens/orders/orders.dart';
import 'package:doctor_perro_helper/screens/pages/calculator/calculator.dart';
import 'package:doctor_perro_helper/screens/pages/settings/settings.dart';
import 'package:doctor_perro_helper/utils/check_for_updates.dart';
import 'package:doctor_perro_helper/utils/version_checker.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  final List<Widget> screens = [
    DashBoard(),
    const Orders(),
    const DolarCalculator(),
    const SettingsPage(),
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(
      Duration.zero,
      () {
        // ignore: use_build_context_synchronously
        checkForUpdates(context);
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateAvailable();
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int index) => setState(() {
            currentIndex = index;
          }),
          children: widget.screens,
          // scrollBehavior: ScrollBehavior,
        ),
      ),
      bottomNavigationBar: navBar(),
    );
  }

  NavigationBar navBar() {
    return NavigationBar(
      selectedIndex: currentIndex,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      onDestinationSelected: (int targetIndex) {
        setState(() {
          currentIndex = targetIndex;
          _pageController.animateToPage(targetIndex,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut);
        });
      },
      height: 60.0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: "Principio",
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt),
          label: "Pedidos",
        ),
        NavigationDestination(
          icon: Icon(Icons.calculate),
          label: "Calculadora",
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: "Ajustes",
        ),
      ],
    );
  }
}
