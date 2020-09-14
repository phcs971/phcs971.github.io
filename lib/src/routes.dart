import 'package:flutter/material.dart';

import 'utils/logger.dart';
import 'pages/home/home.dart';

//TODO ROUTES
const HomeRoute = '/';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Route<dynamic> _page(Widget widget) => MaterialPageRoute(
        builder: (BuildContext context) => widget,
        settings: settings,
      );

  log.i('<Router> To ${settings.name}');

  switch (settings.name) {
    case HomeRoute:
      return _page(HomePage());
    default: //TODO On Unknown Route
      return _page(Container());
  }
}
