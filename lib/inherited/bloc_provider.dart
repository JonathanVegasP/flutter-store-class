import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : assert(bloc != null),
        assert(child != null),
        super(key: key);

  static T of<T extends BlocBase>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_BlocInherited<T>>().bloc;
  }

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocInherited<T>(
      child: widget.child,
      bloc: widget.bloc,
    );
  }
}

class _BlocInherited<T> extends InheritedWidget {
  const _BlocInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  })
      : assert(child != null),
        assert(bloc != null),
        super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocInherited<T> old) => false;
}
