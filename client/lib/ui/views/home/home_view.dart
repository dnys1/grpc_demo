import 'package:flutter/material.dart';

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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('gRPC Demo'),
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Unary')),
              Tab(child: Text('Server Stream')),
              // Tab(child: Text('Client Stream')),
              // Tab(child: Text('Bidirectional')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GreetOnceView(),
            GreetManyView(),
          ],
        ),
      ),
    );
  }
}
