import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';

class UnaryView extends StatelessWidget {
  static const description =
      'Implementation of a unary RPC. The client sends a static request and receives a static response.';

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
            GreetForm(onSubmit: (fname, lname) {
              BlocProvider.of<GreetBloc>(context).add(GreetOnce(
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
              height: 50,
              child: BlocBuilder<GreetBloc, GreetState>(
                builder: (context, state) {
                  if (state is GreetOnceSuccess) {
                    return Text(state.result);
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
