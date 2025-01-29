import 'package:doctor_perro_helper/config/themes/dark_theme.dart';
import 'package:doctor_perro_helper/config/themes/light_theme.dart';
import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:doctor_perro_helper/screens/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:toastification/toastification.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UseSharedPreferences.init();
  await initializeDateFormatting('es_ES');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  return runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        title: "Dr.Perro Helper",
        initialRoute: "/",
        routes: {
          "/": (BuildContext context) => Home(),
        },
      ),
    );
  }
}

// class NavBar extends StatefulWidget {
//   const NavBar({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _NavBarState createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int currentIndex = 0;

//   List routes = [
//     "/",
//     "/calculator"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(

//       selectedIndex: currentIndex,
//       onDestinationSelected: (int index) => Navigate.,
//     );
//   }
// }
