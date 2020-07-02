import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../../core/managers/greet_manager.dart';
import '../../widgets/greet_form.dart';
import '../../widgets/grpc_tab_view.dart';

class BidirectionalView extends StatefulWidget {
  @override
  _BidirectionalViewState createState() => _BidirectionalViewState();
}

class _BidirectionalViewState extends State<BidirectionalView> {
  final List<String> _responses = [];
  final ScrollController _controller = ScrollController();

  static const description =
      'Implementation of bidirectional streaming. The client sends a Stream of requests and simultaneously receives a Stream of responses';

  @override
  Widget build(BuildContext context) {
    return GrpcTabView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: const Text(description),
          ),
          GreetForm(
            onAdd: (fname, lname) {
              context.read<GreetManager>().add(GreetEveryoneAdd(
                    firstName: fname,
                    lastName: lname,
                  ));
            },
            submitLabel: 'Close',
            onSubmit: (_, __) {
              context.read<GreetManager>().add(GreetEveryoneClose());
            },
          ),
          const SizedBox(height: 100),
          Text(
            'Responses (${_responses.length})',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            child: BlocConsumer<GreetBloc, GreetState>(
              listener: (context, state) {
                if (state is GreetEveryoneSuccess) {
                  setState(() {
                    _responses.add(state.result);
                  });
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_controller.hasClients) {
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  });
                } else if (state is GreetInitial) {
                  setState(() {
                    _responses.clear();
                  });
                }
              },
              builder: (context, state) {
                if (state is GreetEveryoneSuccess) {
                  return Container(
                    height: 100,
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: _responses.length,
                      itemBuilder: (context, index) {
                        return Text(_responses[index]);
                      },
                    ),
                  );
                } else if (state is GreetLoading) {
                  return const CircularProgressIndicator();
                } else if (state is GreetFailure) {
                  return Text(
                    '${state.exception.runtimeType}: ${state.exception}',
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const Text('No data');
                }
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
