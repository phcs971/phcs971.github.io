import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/project.dart';
import '../../../locators.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    load();
  }

  final firestore = locator<FirestoreService>();

  void load() async {
    try {
      emit(HomeInitial());
      final projects = await firestore.getProjects();
      emit(HomeLoaded(projects));
    } catch (e) {
      String m;
      try {
        m = e.message;
      } catch (_) {
        m = e.toString();
      }
      emit(HomeError(m));
    }
  }
}
