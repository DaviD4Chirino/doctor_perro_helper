import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/plate.dart';
import 'package:doctor_perro_helper/screens/pages/calculator/calculator.dart';
import 'package:doctor_perro_helper/widgets/current_date.dart';
import 'package:doctor_perro_helper/widgets/current_dolar_price.dart';
import 'package:doctor_perro_helper/widgets/menu_list_item.dart';
import 'package:doctor_perro_helper/widgets/todays_earnings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({
    super.key,
  });

  final List<Widget> screens = [
    DashBoard(),
    DolarCalculator(),
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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) => setState(() {
          currentIndex = index;
        }),
        children: widget.screens,
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
          icon: Icon(Icons.calculate),
          label: "Calculadora",
        ),
      ],
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Image(
        image: AssetImage("lib/assets/logos/logo_border_transparent.png"),
        width: 60.0,
        height: 60.0,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: Sizes().xxl),
          child: const Icon(Icons.search),
        ),
      ],
    );
  }
}

class DashBoard extends StatelessWidget {
  DashBoard({
    super.key,
  });

  final List<Plate> plates = [
    Plate(
      code: "R1",
      title: "Perro Normal",
      ingredients: [
        "Ensalada",
        "Papas",
        "Queso de año",
        "Salsa de ajo",
        "Salsa de Tomate",
      ],
      price: 2.0,
    ),
    Plate(
      code: "R2",
      title: "Perro Especial",
      ingredients: [
        "Queso Kraft",
        "Tocino",
        "Ensalada",
        "Papas",
        "Queso de año",
        "Salsa de ajo",
        "Salsa de Tomate",
      ],
      price: 3.0,
    ),
    Plate(
      code: "R3",
      title: "Hamburguesa",
      ingredients: [
        "Carne",
        "Salsa de la casa",
        "Tocino",
        "Queso Kraft",
      ],
      price: 3.5,
    ),
    Plate(
      code: "R4",
      title: "Hamburguesa Doble",
      ingredients: [
        "Doble Carne",
        "Salsa de la casa",
        "Tocino",
        "Queso Kraft",
      ],
      price: 6.0,
    ),
    Plate(
      code: "R5",
      title: "Salchipapas",
      ingredients: [
        "Papas Fritas",
        "Salchicha",
        "Tocino",
        "Maíz",
        "Queso de res",
        "Queso de Año",
      ],
      price: 3.0,
    ),
    Plate(
      code: "R6",
      title: "Servicio de Papas",
      ingredients: ["Papas Fritas", "Salsa de Tomate"],
      price: 3.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      physics: const BouncingScrollPhysics(),
      children: [
        CurrentDateText(),
        SizedBox(
          height: Sizes().xxl,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TodaysEarnings(),
            CurrentDolarPrice(),
          ],
        ),
        SizedBox(
          height: Sizes().xxxl * 2,
        ),
        const Text(
          "Menú",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: Sizes().xl,
        ),
        ...plates.map(
          (plate) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MenuListItem(
              plate: plate,
            ),
          ),
        ),
      ],
    );
  }
}
