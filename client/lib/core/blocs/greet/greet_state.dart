part of 'greet_bloc.dart';

abstract class GreetState extends Equatable {
  const GreetState();

  @override
  List<Object> get props => [];
}

class GreetInitial extends GreetState {}

class GreetLoading extends GreetState {}

class GreetOnceSuccess extends GreetState {
  final String result;

  const GreetOnceSuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  String toString() {
    return 'GreetOnceSuccess { result: $result }';
  }
}

class GreetManySuccess extends GreetState {
  final String result;

  const GreetManySuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  String toString() {
    return 'GreetManySuccess { result: $result }';
  }
}

class LongGreetSuccess extends GreetState {
  final String result;

  const LongGreetSuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  String toString() {
    return 'LongGreetSuccess { result: $result }';
  }
}

class GreetEveryoneSuccess extends GreetState {
  final String result;

  const GreetEveryoneSuccess(this.result);

  @override
  List<Object> get props => [result];

  @override
  String toString() {
    return 'BidirectionalSuccess { result: $result }';
  }
}

class GreetFailure extends GreetState {
  final String exception;

  const GreetFailure(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'GreetFailure { exception: $exception }';
  }
}
