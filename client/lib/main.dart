import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/blocs/bloc_delegate.dart';
import 'core/blocs/controller/controller_bloc.dart';
import 'core/blocs/greet/greet_bloc.dart';
import 'ui/views/views.dart';

void main() {
  BlocSupervisor.delegate = GrpcBlocDelegate();
  final app = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GreetBloc(),
      ),
      BlocProvider(
        create: (context) => ControllerBloc(
          greetBloc: BlocProvider.of<GreetBloc>(context),
        ),
      ),
    ],
    child: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
