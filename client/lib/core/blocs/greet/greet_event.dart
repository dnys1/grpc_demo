part of 'greet_bloc.dart';

abstract class GreetEvent extends Equatable {
  const GreetEvent();

  @override
  List<Object> get props => [];
}

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
