import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/greet/greet_bloc.dart';
import '../views.dart';

class HomeView extends StatefulWidget {
  const HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('gRPC Demo'),
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Unary')),
              Tab(child: FittedBox(child: Text('Server Stream'))),
              Tab(child: FittedBox(child: Text('Client Stream'))),
              // Tab(child: Text('Bidirectional')),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                BlocProvider.of<GreetBloc>(context).add(GreetReset());
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            GreetOnceView(),
            GreetManyView(),
            LongGreetView(),
          ],
        ),
      ),
    );
  }
}
