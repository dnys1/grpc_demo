import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';

class GreetManyView extends StatelessWidget {
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
            GreetForm(onSubmit: (fname, lname) {
              _responses.clear();
              BlocProvider.of<GreetBloc>(context).add(GreetMany(
                firstName: fname,
                lastName: lname,
              ));
            }),
            const Spacer(),
            Text(
              'Response',
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
                    _responses.add(state.result);
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
