import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_fragment.dart';

class Item {
  String reference;

  Item(this.reference);
}

class _MyInherited extends InheritedWidget {
  _MyInherited({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  final MyInheritedWidgetState data;

  @override
  bool updateShouldNotify(_MyInherited oldWidget) {
    return true;
  }
}

class MyInheritedWidget extends StatefulWidget {
  MyInheritedWidget({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  MyInheritedWidgetState createState() => MyInheritedWidgetState();

  static MyInheritedWidgetState of(
      [BuildContext context, bool rebuild = true]) {
    return (rebuild
            ? context.inheritFromWidgetOfExactType(_MyInherited) as _MyInherited
            : context.ancestorWidgetOfExactType(_MyInherited) as _MyInherited)
        .data;
  }
}

class MyInheritedWidgetState extends State<MyInheritedWidget> {
  /// List of Widgets
  List<Widget> _widgets = <Widget>[AuthFragment()];

  /// Getter (number of widgets)
  int get widgetsCount => _widgets.length;

  /// Getter (current widget)
  Widget get currentWidget => _widgets.last;

  /// Helper method to add an Item
  void navigateTo(Widget widget) {
    setState(() {
      _widgets.add(widget);
    });
  }

  void backPressed() {
    if (_widgets.length == 1) {
      return;
    }

    setState(() {
      _widgets.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _MyInherited(
      data: this,
      child: widget.child,
    );
  }
}

class AuthActivity extends StatefulWidget {
  @override
  _AuthActivityState createState() => _AuthActivityState();
}

class _AuthActivityState extends State<AuthActivity> {
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Title'),
          ),
          body: WidgetContainer()),
    );
  }
}

class WidgetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context);
    return Container(child: state.currentWidget);
  }
}

class WidgetA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context, false);
    return Container(
      child: RaisedButton(
        child: Text('Add Item'),
        onPressed: () {
          state.navigateTo(Text("count: ${state.widgetsCount}"));
        },
      ),
    );
  }
}

class WidgetB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyInheritedWidgetState state = MyInheritedWidget.of(context, false);
    return Container(
      child: RaisedButton(
        child: Text('Remove Item'),
        onPressed: () {
          state.backPressed();
        },
      ),
    );
  }
}

class WidgetC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('I am Widget C');
  }
}
