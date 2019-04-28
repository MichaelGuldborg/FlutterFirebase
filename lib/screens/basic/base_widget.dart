import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/components/slide_right_page_transitions_builder.dart';

class _BaseWidgetStateProvider extends InheritedWidget {
  final BaseWidgetState state;

  _BaseWidgetStateProvider({this.state, child}) : super(child: child);

  @override
  bool updateShouldNotify(_BaseWidgetStateProvider old) => false;
}

/// TODO TEST THIS BAD BOI OUT
class BaseWidget extends StatefulWidget {
  final String initialRoute;
  final Map<String, Widget> routes;
  final Map<String, String> titles;
  final Widget initialLeading;

  const BaseWidget({
    Key key,
    @required this.initialRoute,
    @required this.routes,
    this.initialLeading = const Center(),
    this.titles,
  }) : super(key: key);

  @override
  BaseWidgetState createState() => BaseWidgetState();
}

class BaseWidgetState extends State<BaseWidget> {
  static BaseWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_BaseWidgetStateProvider)
            as _BaseWidgetStateProvider)
        .state;
  }

  final navKey = GlobalKey<NavigatorState>();
  String currentRouteName;

  @override
  initState() {
    super.initState();
    currentRouteName = widget.initialRoute;
  }

  get isInitialRoute => currentRouteName == widget.initialRoute;

  get routeTitle => widget.titles[currentRouteName] ?? "";

  Route onGenerateRoute(RouteSettings settings) {
    final String routeName = settings.name;
    final Widget nextWidget = widget.routes[routeName];
    setState(() {
      currentRouteName = routeName;
    });

    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => nextWidget,
    );
  }

  Future<bool> onBackPress() async {
    if (!navKey.currentState.canPop()) {
      return true;
    }
    navKey.currentState.pop();
    updateRouteName();
    return false;
  }

  void updateRouteName() {
    navKey.currentState.popUntil((route) {
      final bool isInitialRoute = route.settings.isInitialRoute;
      final String routeName = isInitialRoute ? widget.initialRoute : route.settings.name;
      setState(() {
        currentRouteName = routeName;
      });
      return true;
    });
  }

  /// Maybe use SafeArea
  @override
  Widget build(BuildContext context) {
    return _BaseWidgetStateProvider(
      state: this,
      child: WillPopScope(
        onWillPop: onBackPress,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: isInitialRoute
                ? widget.initialLeading
                : IconButton(
                    icon: const BackButtonIcon(),
                    color: Colors.black,
                    onPressed: onBackPress,
                  ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    routeTitle,
                    style:
                        TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                  )),
            ),
          ),
          body: MaterialApp(
            navigatorKey: navKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: SlideRightPageTransitionsBuilder(),
                TargetPlatform.android: SlideRightPageTransitionsBuilder(),
              }),
            ),
            home: widget.routes[widget.initialRoute],
            onGenerateRoute: onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
