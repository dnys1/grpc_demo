import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../../widgets/greet_form.dart';
import '../../widgets/grpc_tab_view.dart';

class ClientStreamView extends StatelessWidget {
  static const description =
      'Implementation of client-side streaming. The client sends a Stream of requests, then receives a static response.';

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
              BlocProvider.of<GreetBloc>(context).add(LongGreetAdd(
                firstName: fname,
                lastName: lname,
              ));
            },
            onSubmit: (_, __) {
              BlocProvider.of<GreetBloc>(context).add(LongGreetClose());
            },
          ),
          const SizedBox(height: 100),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
