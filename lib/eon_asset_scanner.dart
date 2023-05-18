import 'package:eon_asset_scanner/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'core/constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

class EonAssetScanner extends StatelessWidget {
  const EonAssetScanner({super.key});

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..backgroundColor = Colors.black54
      ..indicatorColor = Colors.blue;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
          ),
        ),
      ),
      themeMode: ThemeMode.dark,
      builder: EasyLoading.init(),
      routes: {
        '/': (context) => const LoginScreen(),
        'home': (context) => const HomeScreen(),
        'scan': (context) => const ScanScreen(),
      },
    );
  }
}
