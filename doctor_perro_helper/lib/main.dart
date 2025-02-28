import 'package:doctor_perro_helper/config/themes/app_theme.dart';
import 'package:doctor_perro_helper/models/providers/global_settings.dart';

import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:doctor_perro_helper/screens/pages/home/home.dart';
import 'package:doctor_perro_helper/utils/google/google.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await UseSharedPreferences.init();

  await initializeDateFormatting('es_ES');
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  /// Put here anything that you need to initialize in the app,
  /// this should be use for things like class init whose class exist inside
  /// this repo, and not from dependencies unless necessary.

  Future<void> initialization() async {
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await silentSignInWithGoogle();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      // await ref.watch(globalSettingsNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        title: "Dr.Perro Helper",
        initialRoute: "",
        routes: {
          "": (BuildContext context) => Home(),
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
