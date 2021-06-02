part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Project> projects;
  HomeLoaded(this.projects);

  @override
  List<Object> get props => [projects];
}

class HomeError extends HomeState {
  final String? message;

  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
