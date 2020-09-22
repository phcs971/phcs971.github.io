import 'package:flutter/material.dart';

import 'components/error.dart';
import 'utils/logger.dart';
import 'pages/home/home.dart';
import 'pages/info/info.dart';
import 'pages/conquistas/conquistas.dart';
import 'pages/project/project.dart';
import 'pages/startup/startup.dart';
import 'pages/newproject/newproject.dart';
import 'pages/newconquista/newconquista.dart';

const StartupRoute = '/';
const HomeRoute = '/projetos';
const InfoRoute = '/info';
const ConquistasRoute = '/conquistas';
const NewProjectRoute = '/projeto-novo';
const NewConquistaRoute = '/conquista-novo';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Route<dynamic> _page(Widget widget) => FadePageRoute(page: widget, settings: settings);

  log.i('<Router> To ${settings.name}');

  List<String> routeArgs = settings.name.split('/').where((str) => str.isNotEmpty).toList();
  String routeName = routeArgs.isEmpty ? "/" : "/${routeArgs.removeAt(0)}";

  switch (routeName) {
    case StartupRoute:
      return _page(StartupPage());
    case HomeRoute:
      if (routeArgs.isNotEmpty) return _page(ProjectPage(routeArgs[0]));
      return _page(HomePage());
    case ConquistasRoute:
      if (routeArgs.isNotEmpty) return _page(Container());
      return _page(ConquistasPage());
    case InfoRoute:
      return _page(InfoPage());
    case NewProjectRoute:
      return _page(NewProjectPage());
    case NewConquistaRoute:
      return _page(NewConquistaPage());
    default:
      log.e("<Router> Unknown Route: $routeName");
      return _page(ErroWidget("404\nPágina Não Encontrada"));
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
