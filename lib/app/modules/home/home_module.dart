import 'package:dragonflylabs/app/modules/home/home_page.dart';
import 'package:dragonflylabs/app/modules/home/pages/contact_page.dart';
import 'package:dragonflylabs/app/modules/home/pages/work/work_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const HomePage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/contact',
      child: (_) => const ContactPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/work',
      child: (_) => const WorkPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
