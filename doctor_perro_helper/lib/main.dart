import 'package:doctor_perro_helper/config/themes/app_theme.dart';
import 'package:doctor_perro_helper/models/notification_server/notification_server.dart';
import 'package:doctor_perro_helper/models/providers/theme_mode_provider.dart';

import 'package:doctor_perro_helper/models/routes.dart';
import 'package:doctor_perro_helper/models/use_shared_preferences.dart';
import 'package:doctor_perro_helper/screens/orders/make_new_order.dart';
import 'package:doctor_perro_helper/screens/pages/home/home.dart';
import 'package:doctor_perro_helper/utils/google/google.dart';
import 'package:doctor_perro_helper/utils/notifications_handlers/notification_on_dolar_price_changed.dart';
import 'package:doctor_perro_helper/utils/notifications_handlers/notification_on_menu_order_changed.dart';
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

    /* if (kDebugMode) {
      var pl1 = PlateList.r1.amount(1).spread();
      var pl2 = PlateList.r4.amount(2).spread();
      print(pl1);
      print(pl2);
    } */
  }

  /// Put here anything that you need to initialize in the app,
  /// this should be use for things like class init whose class exist inside
  /// this repo, and not from dependencies unless necessary.

  Future<void> initialization() async {
    Future<void> awaitFunctions() async {
      silentSignInWithGoogle();
      NotificationServer.initialize();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await awaitFunctions();
        notificationOnMenuOrderChanged();
        notificationOnDolarPriceChanged();
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode themeMode = ref.watch(themeModeNotifierProvider);

    return ToastificationWrapper(
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeMode,
        title: "Dr.Perro Helper",
        initialRoute: Paths.home,
        routes: {
          Paths.home: (BuildContext context) => Home(),
          Paths.newOrder: (BuildContext context) => const MakeNewOrder(),
        },
      ),
    );
  }
}
