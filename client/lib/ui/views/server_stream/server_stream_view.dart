import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';

class ServerStreamView extends StatefulWidget {
  @override
  _ServerStreamViewState createState() => _ServerStreamViewState();
}

class _ServerStreamViewState extends State<ServerStreamView> {
  final List<String> _responses = [];
  bool _enabled = true;

  static const description =
      'Implementation of server-side streaming. The client sends one request and receives a Stream of responses.';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
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
            const Spacer(flex: 2),
            Text(
              'Responses (${_responses.length})',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              child: BlocConsumer<GreetBloc, GreetState>(
                listener: (context, state) {
                  if (state is GreetManySuccess) {
                    setState(() {
                      _responses.add(state.result);
                      _enabled = false;
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
                    return ListView.builder(
                      itemCount: _responses.length,
                      itemBuilder: (context, index) {
                        return Text(_responses[index]);
                      },
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
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
