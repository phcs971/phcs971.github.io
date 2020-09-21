import 'package:get_it/get_it.dart';

import 'services/services.dart';
import 'utils/logger.dart';

export 'services/services.dart';

GetIt locator = GetIt.instance;

Future locatorSetup() async {
  log.v("<Locator> Setup Start");
  log.v("<Locator> Registering Firestore Service");
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());
  log.v("<Locator> Registering Auth Service");
  locator.registerLazySingleton<AuthService>(() => AuthService());
  log.v("<Locator> Registering Navigation Service");
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  log.v("<Locator> Setup Finish");
}
