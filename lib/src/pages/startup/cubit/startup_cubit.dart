import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import '../../../locators.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInitial()) {
    _startup();
  }

  final nav = locator<NavigationService>();

  void _startup() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kIsWeb) return nav.to(HomeRoute);
      //TODO Em Caso de Ser o App Mobile Verificar Se Existe Usuário do Google e Logar se Necessario
    });
  }
}
