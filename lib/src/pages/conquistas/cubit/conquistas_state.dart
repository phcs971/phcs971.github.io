part of 'conquistas_cubit.dart';

abstract class ConquistasState extends Equatable {
  const ConquistasState();

  @override
  List<Object?> get props => [];
}

class ConquistasInitial extends ConquistasState {
  @override
  List<Object> get props => [];
}

class ConquistasLoaded extends ConquistasState {
  final List<Conquista> conquistas;
  ConquistasLoaded(this.conquistas);

  @override
  List<Object> get props => [conquistas];
}

class ConquistasError extends ConquistasState {
  final String? message;

  ConquistasError(this.message);

  @override
  List<Object?> get props => [message];
}
