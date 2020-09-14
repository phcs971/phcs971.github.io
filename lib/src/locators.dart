import 'package:get_it/get_it.dart';

import 'services/services.dart';
import 'utils/logger.dart';

export 'services/services.dart';

GetIt locator = GetIt.instance;

Future locatorSetup() async {
  log.v("<Locator> Setup Start");
  log.v("<Locator> Registering Navigation Service");
  locator.registerSingleton<NavigationService>(NavigationService());
  log.v("<Locator> Setup Finish");
}
