import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common/locator.dart';
import 'package:food_delivery/common/service_call.dart';
import 'package:food_delivery/view/login/welcome_view.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';
import 'package:food_delivery/view/on_boarding/startup_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🔥 Supabase
import 'package:supabase_flutter/supabase_flutter.dart';

// 🔥 Firebase
import 'package:food_delivery/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/globs.dart';
import 'common/my_http_overrides.dart';

SharedPreferences? prefs;

Future<void> main() async {
  // WAJIB: sebelum apa pun
  WidgetsFlutterBinding.ensureInitialized();

  // Locator & HTTP override (buat backend lama kamu)
  setUpLocator();
  HttpOverrides.global = MyHttpOverrides();

  // 🔥 Init Supabase
  // PASTIKAN url & anonKey DI-COPY PERSIS dari:
  // Supabase → Settings → API → Project URL & anon public
  await Supabase.initialize(
    url: 'https://gdwnpoggwitzbfgmpbkm.supabase.co', // cek lagi di dashboard-mu
    anonKey: 'sb_publishable_fWkrZ2GJnLITsoMOPEnc3Q_6S9mnem5', // anon public key
  );

  // 🔥 Init Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔥 SharedPreferences
  prefs = await SharedPreferences.getInstance();

  // 🔥 Cek status login tersimpan
  final bool isLoggedIn = Globs.udValueBool(Globs.userLogin);
  if (isLoggedIn) {
    ServiceCall.userPayload = Globs.udValue(Globs.userPayload);
  }

  // Konfigurasi loading global
  configLoading();

  // Tentukan halaman awal
  runApp(
    MyApp(
      defaultHome: isLoggedIn ? const MainTabView() : const StartupView(),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = TColor.primaryText
    ..backgroundColor = TColor.primary
    ..indicatorColor = Colors.yellow
    ..textColor = TColor.primaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  final Widget defaultHome;
  const MyApp({super.key, required this.defaultHome});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Metropolis",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: widget.defaultHome,
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case "welcome":
            return MaterialPageRoute(
              builder: (context) => const WelcomeView(),
            );
          case "Home":
            return MaterialPageRoute(
              builder: (context) => const MainTabView(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => Scaffold(
                body: Center(
                  child: Text("No path for ${routeSettings.name}"),
                ),
              ),
            );
        }
      },
      builder: (context, child) {
        return FlutterEasyLoading(child: child);
      },
    );
  }
}
