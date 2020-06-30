import 'package:flutter/material.dart';

class GrpcTabView extends StatelessWidget {
  /// The child of the tab view, typically a [Column].
  final Widget child;

  const GrpcTabView({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 300),
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
