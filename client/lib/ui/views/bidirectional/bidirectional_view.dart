import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/controller/controller_bloc.dart';
import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';

class BidirectionalView extends StatefulWidget {
  @override
  _BidirectionalViewState createState() => _BidirectionalViewState();
}

class _BidirectionalViewState extends State<BidirectionalView> {
  final List<String> _responses = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            GreetForm(
              onAdd: (fname, lname) {
                BlocProvider.of<ControllerBloc>(context).add(BidirectionalAdd(
                  firstName: fname,
                  lastName: lname,
                ));
              },
              submitLabel: 'Close',
              onSubmit: (_, __) {
                BlocProvider.of<ControllerBloc>(context)
                    .add(BidirectionalClose());
              },
            ),
            const Spacer(),
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
                  if (state is BidirectionalSuccess) {
                    setState(() {
                      _responses.add(state.result);
                    });
                  } else if (state is GreetInitial) {
                    setState(() {
                      _responses.clear();
                    });
                  }
                },
                builder: (context, state) {
                  if (state is BidirectionalSuccess) {
                    return Container(
                      height: 100,
                      child: ListView.builder(
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
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
