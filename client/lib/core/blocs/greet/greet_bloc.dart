import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../services/greet_service.dart';

part 'greet_event.dart';
part 'greet_state.dart';

class GreetBloc extends Bloc<GreetEvent, GreetState> {
  final GreetService _greetService;

  GreetBloc({GreetService greetService})
      : _greetService = greetService ?? GreetService();

  @override
  GreetState get initialState => GreetInitial();

  @override
  Stream<GreetState> mapEventToState(
    GreetEvent event,
  ) async* {
    if (event is GreetOnce) {
      yield* _mapGreetOnceToState(event.firstName, event.lastName);
    } else if (event is GreetMany) {
      yield* _mapGreetManyToState(event.firstName, event.lastName);
    }
  }

  Stream<GreetState> _mapGreetOnceToState(
      String firstName, String lastName) async* {
    yield GreetLoading();
    try {
      final result = await _greetService.greetOnce(firstName, lastName);
      yield GreetOnceSuccess(result);
    } catch (e) {
      yield GreetFailure(e);
    }
  }

  Stream<GreetState> _mapGreetManyToState(
      String firstName, String lastName) async* {
    yield GreetLoading();
    try {
      final responses = _greetService.greetMany(firstName, lastName);
      await for (var result in responses) {
        yield GreetManySuccess(result);
      }
    } catch (e) {
      yield GreetFailure(e);
    }
  }
}
