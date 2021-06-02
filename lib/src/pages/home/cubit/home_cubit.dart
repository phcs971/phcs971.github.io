import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../models/project.dart';
import '../../../utils/utils.dart';
import '../../../locators.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    load();
  }

  final FirestoreService? firestore = locator<FirestoreService>();

  void load() async {
    try {
      emit(HomeInitial());
      final projects = await firestore!.getProjects();
      emit(HomeLoaded(projects));
    } catch (e) {
      String? m;
      try {
        m = (e as PlatformException).message;
      } catch (_) {
        m = e.toString();
      }
      log.e("<HomeCubit> $m");
      emit(HomeError(m));
    }
  }
}
