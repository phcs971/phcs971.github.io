import 'package:flutter/material.dart';

import 'utils/logger.dart';
import 'pages/home/home.dart';
import 'pages/info/info.dart';
import 'pages/conquistas/conquistas.dart';

const HomeRoute = '/';
const InfoRoute = '/info';
const ConquistasRoute = '/conquistas';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Route<dynamic> _page(Widget widget) => FadePageRoute(page: widget, settings: settings);

  log.i('<Router> To ${settings.name}');

  switch (settings.name) {
    case HomeRoute:
      return _page(HomePage());
    case InfoRoute:
      return _page(InfoPage());
    case ConquistasRoute:
      return _page(ConquistasPage());
    default: //TODO On Unknown Route
      return _page(Container());
  }
}

class FadePageRoute<T> extends PageRoute<T> {
  final Widget page;
  final RouteSettings settings;

  FadePageRoute({this.page, this.settings}) : super(settings: settings);

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      FadeTransition(opacity: animation, child: page);

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}
