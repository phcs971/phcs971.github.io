import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import '../../../locators.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupLoading()) {
    _startup();
  }

  final NavigationService? nav = locator<NavigationService>();
  final AuthService? auth = locator<AuthService>();

  void _startup() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (kIsWeb) return nav!.to(HomeRoute);
      if (await auth!.hasUser()) return nav!.to(HomeRoute);
      login();
    });
  }

  void login() async {
    if (state is StartupWaiting) emit(StartupLoading());
    final res = await auth!.login();
    if (res is bool && res) return nav!.to(HomeRoute);
    emit(StartupWaiting());
  }
}
