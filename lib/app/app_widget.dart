import 'package:dragonflylabs/app/design/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Dragonfly Labs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: AppColors.blue, brightness: Brightness.dark),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
