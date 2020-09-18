import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../../locators.dart';

part 'conquistas_state.dart';

class ConquistasCubit extends Cubit<ConquistasState> {
  ConquistasCubit() : super(ConquistasInitial()) {
    load();
  }

  final firestore = locator<FirestoreService>();

  void load() async {
    try {
      emit(ConquistasInitial());
      final conq = await firestore.getConquistas();
      emit(ConquistasLoaded(conq));
    } catch (e) {
      String m;
      try {
        m = e.message;
      } catch (_) {
        m = e.toString();
      }
      log.e("<ConquistasCubit> $m");
      emit(ConquistasError(m));
    }
  }
}
