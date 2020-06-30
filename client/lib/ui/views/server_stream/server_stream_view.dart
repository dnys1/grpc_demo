import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';
import '../../widgets/grpc_tab_view.dart';

class ServerStreamView extends StatefulWidget {
  @override
  _ServerStreamViewState createState() => _ServerStreamViewState();
}

class _ServerStreamViewState extends State<ServerStreamView> {
  final ScrollController _controller = ScrollController();
  final List<String> _responses = [];
  bool _enabled = true;

  static const description =
      'Implementation of server-side streaming. The client sends one request and receives a Stream of responses.';

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
            submitEnabled: _enabled,
            onSubmit: (fname, lname) {
              _responses.clear();
              BlocProvider.of<GreetBloc>(context).add(GreetMany(
                firstName: fname,
                lastName: lname,
              ));
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
          BlocConsumer<GreetBloc, GreetState>(
            listener: (context, state) {
              if (state is GreetManySuccess) {
                setState(() {
                  _responses.add(state.result);
                  _enabled = false;
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
                  _enabled = true;
                });
              }
            },
            builder: (context, state) {
              if (state is GreetManySuccess) {
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
