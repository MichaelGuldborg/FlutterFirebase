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

  final navKey = GlobalKey<NavigatorState>();
  final List<String> routeTitles = ["Dashboard"];
  bool get isInitialRoute => routeTitles.length == 1;

  Future<bool> onBackPress() async {
    if (isInitialRoute) {
      return true;
    }
    navKey.currentState.pop();
    setState(() {
      routeTitles.removeLast();
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
          body: MaterialApp(
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              }),
            ),
            home: DashboardScreen(),
            onGenerateRoute: onGenerateRoute,
          ),
        ),
      ),
    );
  }

  final routes = <String, Widget>{
    DashboardWidgetRoutes.bulletin_list: BulletinScreen(),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final String routeName = settings.name;
    final String routeTitle = routeName;

    Widget nextWidget = routes[routeName];
    setState(() {
      routeTitles.add(routeTitle);
    });

    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => nextWidget,
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
                routeTitles.last,
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              )),
        ),
      );
}
