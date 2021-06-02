part of 'project_cubit.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {
  @override
  List<Object> get props => [];
}

class ProjectLoaded extends ProjectState {
  final Project project;
  ProjectLoaded(this.project);

  @override
  List<Object> get props => [project];
}

class ProjectError extends ProjectState {
  final String? message;

  ProjectError(this.message);

  @override
  List<Object?> get props => [message];
}
