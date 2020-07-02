import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../services/greet_service_base.dart';

part 'greet_event.dart';
part 'greet_state.dart';

class GreetBloc extends Bloc<GreetEvent, GreetState> {
  final GreetServiceBase _greetService;

  GreetBloc(this._greetService);

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
    } else if (event is LongGreetAdd) {
      yield* _mapLongGreetAddToState(event.firstName, event.lastName);
    } else if (event is LongGreetClose) {
      yield* _mapLongGreetCloseToState();
    } else if (event is GreetEveryoneAdd) {
      yield* _mapBidirectionalAddToState(event.firstName, event.lastName);
    } else if (event is GreetReset) {
      reset();
      yield GreetInitial();
    }
  }

  Stream<GreetState> _mapGreetOnceToState(String firstName, String lastName) async* {
    yield GreetLoading();
    try {
      final result = await _greetService.greetOnce(firstName, lastName);
      yield GreetOnceSuccess(result);
    } catch (e) {
      yield GreetFailure(e.toString());
    }
  }

  Stream<GreetState> _mapGreetManyToState(String firstName, String lastName) async* {
    yield GreetLoading();
    try {
      final responses = _greetService.greetMany(firstName, lastName);
      await for (var result in responses) {
        yield GreetManySuccess(result);
      }
    } catch (e) {
      yield GreetFailure(e.toString());
    }
  }

  StreamController<List<String>> _longGreetController;
  Completer<String> _longGreetCompleter;

  Stream<GreetState> _mapLongGreetAddToState(String firstName, String lastName) async* {
    if (_longGreetController == null) {
      yield GreetLoading();
      _longGreetController = StreamController<List<String>>();
      _longGreetCompleter = Completer<String>();
      _greetService
          .longGreet(_longGreetController.stream)
          .then((result) => _longGreetCompleter.complete(result))
          .catchError((err) {
        _longGreetCompleter.completeError(err);
        add(LongGreetClose());
      });
    }
    _longGreetController.add([firstName, lastName]);
  }

  Stream<GreetState> _mapLongGreetCloseToState() async* {
    if (_longGreetController == null) {
      return;
    }
    _longGreetController.close();
    try {
      final result = await _longGreetCompleter.future;
      yield LongGreetSuccess(result);
    } catch (e) {
      yield GreetFailure(e.toString());
    } finally {
      _longGreetController = null;
      _longGreetCompleter = null;
    }
  }

  StreamController<List<String>> bidirectionalController;

  Stream<GreetState> _mapBidirectionalAddToState(
      String firstName, String lastName) async* {
    if (bidirectionalController == null) {
      yield GreetLoading();
      bidirectionalController = StreamController<List<String>>();
      bidirectionalController.add([firstName, lastName]);
      final stream = _greetService.greetEveryone(bidirectionalController.stream);
      try {
        await for (var result in stream) {
          yield GreetEveryoneSuccess(result);
        }
      } catch (e) {
        yield GreetFailure(e.toString());
      } finally {
        closeBidirectional();
      }
    }
  }

  void closeBidirectional() {
    if (bidirectionalController != null) {
      bidirectionalController.close();
      bidirectionalController = null;
    }
  }

  void reset() {
    if (_longGreetController != null) {
      _longGreetController.close();
      _longGreetController = null;
      _longGreetCompleter = null;
    }

    if (bidirectionalController != null) {
      bidirectionalController.close();
      bidirectionalController = null;
    }
  }
}
