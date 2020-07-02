part of 'greet_bloc.dart';

abstract class GreetEvent extends Equatable {
  const GreetEvent();

  @override
  List<Object> get props => [];
}

class GreetReset extends GreetEvent {}

class GreetOnce extends GreetEvent {
  final String firstName;
  final String lastName;

  const GreetOnce({
    @required this.firstName,
    @required this.lastName,
  });

  @override
  List<Object> get props => [firstName, lastName];

  @override
  String toString() {
    return 'GreetOnce { firstName: $firstName, lastName: $lastName }';
  }
}

class GreetMany extends GreetEvent {
  final String firstName;
  final String lastName;

  const GreetMany({
    @required this.firstName,
    @required this.lastName,
  });

  @override
  List<Object> get props => [firstName, lastName];

  @override
  String toString() {
    return 'GreetMany { firstName: $firstName, lastName: $lastName }';
  }
}

class LongGreetAdd extends GreetEvent {
  final String firstName;
  final String lastName;

  const LongGreetAdd({
    @required this.firstName,
    @required this.lastName,
  });

  @override
  List<Object> get props => [firstName, lastName];

  @override
  String toString() {
    return 'LongGreetAdd { firstName: $firstName, lastName: $lastName }';
  }
}

class LongGreetClose extends GreetEvent {}

class GreetEveryoneAdd extends GreetEvent {
  final String firstName;
  final String lastName;

  const GreetEveryoneAdd({
    @required this.firstName,
    @required this.lastName,
  });

  @override
  List<Object> get props => [firstName, lastName];

  @override
  String toString() {
    return 'BidirectionalAdd { firstName: $firstName, lastName: $lastName }';
  }
}

class GreetEveryoneClose extends GreetEvent {}
