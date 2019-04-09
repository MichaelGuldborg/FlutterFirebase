import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/auth/auth_fragment.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';

// Inherited widget
// https://medium.com/flutter-community/widget-state-buildcontext-inheritedwidget-898d671b7956

/*
auth_widget
  auth_view
  login_view
  register_view
 */

class _StateProvider extends InheritedWidget {
  _StateProvider({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  final AuthActivityState state;

  @override
  bool updateShouldNotify(_StateProvider oldWidget) {
    return true;
  }
}

class AuthActivity extends StatefulWidget {
  @override
  AuthActivityState createState() => AuthActivityState();

  static AuthActivityState of([BuildContext context, bool rebuild = true]) {
    return (rebuild
            ? context.inheritFromWidgetOfExactType(_StateProvider)
                as _StateProvider
            : context.ancestorWidgetOfExactType(_StateProvider)
                as _StateProvider)
        .state;
  }
}

class AuthActivityState extends State<AuthActivity> {
  /// Authentication service/provider instance
  final AuthService _authService = AuthService();

  AuthService get authService => _authService;

  /// List of Widgets
  List<Widget> _fragments = <Widget>[AuthFragment()];

  /// Getter (current widget)
  Widget get currentFragment => _fragments.last;

  bool get isRoot => _fragments.length == 1;

  /// Navigation method
  void navigateTo(Widget widget) {
    setState(() {
      _fragments.add(widget);
    });
  }

  /// BackPress override functions
  Future<bool> backPressed() async {
    if (_fragments.length == 1) {
      return true;
    }

    setState(() {
      _fragments.removeLast();
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backPressed,
      child: _StateProvider(
        state: this,
        child: Scaffold(
            appBar: AppBar(
              leading: isRoot ? Container() : BackButton(),
              title: Text('Title'),
            ),
            body: this.currentFragment),
      ),
    );
  }
}
