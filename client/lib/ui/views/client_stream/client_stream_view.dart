import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';

class ClientStreamView extends StatelessWidget {
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
                BlocProvider.of<GreetBloc>(context).add(LongGreetAdd(
                  firstName: fname,
                  lastName: lname,
                ));
              },
              onSubmit: (_, __) {
                BlocProvider.of<GreetBloc>(context).add(LongGreetClose());
              },
            ),
            const Spacer(),
            Text(
              'Response',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            BlocBuilder<GreetBloc, GreetState>(
              builder: (context, state) {
                if (state is LongGreetSuccess) {
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
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
