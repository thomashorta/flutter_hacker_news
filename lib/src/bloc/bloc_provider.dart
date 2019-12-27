import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  BlocProvider({Key key, @required this.bloc, @required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BlocProviderState();
  }

  static B of<B extends Bloc>(BuildContext context) {
    return (context.findAncestorWidgetOfExactType<BlocProvider<B>>()).bloc;
  }
}

class BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
