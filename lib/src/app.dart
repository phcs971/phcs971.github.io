import 'package:flutter/material.dart';

import 'utils/utils.dart';
import 'routes.dart';
import 'locators.dart';
import 'styles.dart';

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log.v("<App> (Re)Loaded");
    return GestureDetector(
      onTap: () {
        log.v("<App> Reseting Focus");
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        title: longAppName,
        theme: themeData,
        initialRoute: StartupRoute,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
