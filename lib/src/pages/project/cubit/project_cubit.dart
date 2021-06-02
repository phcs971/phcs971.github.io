import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../../../locators.dart';
import '../../../utils/utils.dart';
import '../../../models/models.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final String id;
  ProjectCubit(this.id) : super(ProjectInitial()) {
    load();
  }

  final FirestoreService? firestore = locator<FirestoreService>();
  void load() async {
    try {
      emit(ProjectInitial());
      final project = await firestore!.getProject(id);
      emit(ProjectLoaded(project));
    } catch (e) {
      String? m;
      try {
        m = (e as PlatformException).message;
      } catch (_) {
        m = e.toString();
      }
      log.e("<ProjectCubit> $m");
      emit(ProjectError(m));
    }
  }
}
