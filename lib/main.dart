import 'package:flutter/widgets.dart';

import 'src/app.dart';
import 'src/locators.dart';
import 'src/utils/logger.dart';

void main() async {
  log.v("<Main> Start");

  WidgetsFlutterBinding.ensureInitialized();

  log.v("<Main> Locator Setup - Start");
  await locatorSetup();
  log.v("<Main> Locator Setup - Finish");

  log.v("<Main> Run App");

  runApp(PortfolioApp());
}
