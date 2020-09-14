import 'package:flutter/widgets.dart';

export '../routes.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  Future<dynamic> to(String routeName, [dynamic arguments]) =>
      navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);

  Future<dynamic> push(String routeName, [dynamic arguments]) =>
      navigatorKey.currentState.pushNamed(routeName, arguments: arguments);

  void pop(dynamic result) => navigatorKey.currentState.pop(result);
}
