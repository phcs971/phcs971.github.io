part of 'startup_cubit.dart';

abstract class StartupState extends Equatable {
  const StartupState();

  @override
  List<Object> get props => [];
}

class StartupLoading extends StartupState {}

class StartupWaiting extends StartupState {}
