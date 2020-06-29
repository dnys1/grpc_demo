import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../greet/greet_bloc.dart';

part 'controller_state.dart';

class ControllerBloc extends Bloc<GreetEvent, ControllerState> {
  final GreetBloc greetBloc;

  ControllerBloc({@required this.greetBloc});

  @override
  ControllerState get initialState => ControllerInitial();

  @override
  Stream<ControllerState> mapEventToState(
    GreetEvent event,
  ) async* {
    if (event is BidirectionalAdd) {
      if (greetBloc.bidirectionalController != null) {
        greetBloc.bidirectionalController
            .add([event.firstName, event.lastName]);
        return;
      }
    } else if (event is BidirectionalClose) {
      greetBloc.closeBidirectional();
      return;
    }
    greetBloc.add(event);
  }
}
