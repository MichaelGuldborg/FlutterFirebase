import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/main.dart';
import 'package:flutter_firebase_app/screens/dashboard/bulletin_screen.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_firebase_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardWidgetRoutes {
  static const dashboard = "Dashboard";
  static const bulletin_list = "Bulletins";
}

class _DashboardStateProvider extends InheritedWidget {
  final DashboardWidgetState state;

  _DashboardStateProvider({this.state, child}) : super(child: child);

  @override
  bool updateShouldNotify(_DashboardStateProvider old) => false;
}

class DashboardWidget extends StatefulWidget {
  @override
  DashboardWidgetState createState() => DashboardWidgetState();
}

class DashboardWidgetState extends State<DashboardWidget> {
  static DashboardWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_DashboardStateProvider)
            as _DashboardStateProvider)
        .state;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Dashboard auth guard
    Future.delayed(const Duration(seconds: 1), () {
      if (auth.currentUser == null) {
        AppNavigator.of(context).pushReplacementNamed(AppRoutes.auth);
      }
    });
  }

  final List<String> _history = [DashboardWidgetRoutes.dashboard];
  final routes = <String, Widget>{
    DashboardWidgetRoutes.dashboard: DashboardScreen(),
    DashboardWidgetRoutes.bulletin_list: BulletinScreen(),
  };

  get isInitialRoute => _history.length == 1;

  void pushNamed(String name) {
    if (!routes.containsKey(name)) {
      throw FlutterError("Could not find route $name");
    }

    setState(() {
      _history.add(name);
    });
  }

  Future<bool> onBackPress() async {
    if (isInitialRoute) {
      return true;
    }
    setState(() {
      _history.removeLast();
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _DashboardStateProvider(
      state: this,
      child: WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          appBar: _appBar(),
          body: AnimatedContainer(
            duration: const Duration(seconds: 3),
            curve: Curves.bounceIn,
            child: routes[_history.last],
          ),
        ),
      ),
    );
  }

  Widget _appBar() => AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: isInitialRoute
            ? IconButton(
                icon: Icon(FontAwesomeIcons.user, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.settings);
                })
            : IconButton(icon: const BackButtonIcon(), color: Colors.black, onPressed: onBackPress),
        actions: <Widget>[],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                _history.last,
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              )),
        ),
      );
}
