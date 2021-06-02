import 'package:flutter/widgets.dart';

import '../utils/logger.dart';

export '../routes.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  Future<dynamic> to(String routeName, [dynamic arguments]) =>
      _navigator!.pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> push(String routeName, [dynamic arguments]) =>
      _navigator!.pushNamed(routeName, arguments: arguments);

  void pop([dynamic result]) {
    log.i("<Router> To Previous Route");
    _navigator!.pop(result);
  }

  void popAllTo(String routeName, [dynamic arguments]) {
    while (_navigator!.canPop()) pop();
    to(routeName, arguments);
  }
}
