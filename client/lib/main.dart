import 'package:client/core/blocs/greet/greet_bloc.dart';
import 'package:client/core/models/greet/greet.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';

import 'ui/views/views.dart';

ClientChannel channel;
GreetServiceClient client;

void main() {
  final app = BlocProvider(
    create: (_) => GreetBloc(),
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
    );
  }
}
