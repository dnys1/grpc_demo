import 'package:meta/meta.dart';

import '../blocs/greet/greet_bloc.dart';

class GreetManager {
  final GreetBloc greetBloc;

  const GreetManager({@required this.greetBloc});

  void add(GreetEvent event) {
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
