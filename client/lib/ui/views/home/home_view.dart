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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('gRPC Demo'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(child: Text('Unary')),
              Tab(child: Text('Server Stream')),
              Tab(child: Text('Client Stream')),
              Tab(child: Text('Bidirectional')),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'Reset',
              onPressed: () {
                BlocProvider.of<GreetBloc>(context).add(GreetReset());
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            UnaryView(),
            ServerStreamView(),
            ClientStreamView(),
            BidirectionalView(),
          ],
        ),
      ),
    );
  }
}
