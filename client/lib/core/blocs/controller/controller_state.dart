part of 'controller_bloc.dart';

abstract class ControllerState extends Equatable {
  const ControllerState();
}

class ControllerInitial extends ControllerState {
  @override
  List<Object> get props => [];
}
