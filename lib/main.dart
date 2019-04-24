import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/address/address_widget.dart';
import 'package:flutter_firebase_app/screens/auth/auth_widget.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_widget.dart';
import 'package:flutter_firebase_app/screens/event/event_screen.dart';
import 'package:flutter_firebase_app/screens/settings/settings_screen.dart';
import 'package:flutter_firebase_app/screens/splash_screen.dart';

void main() => runApp(App());

// https://stackoverflow.com/questions/53672171/how-to-get-build-and-version-number-of-flutter-app

class App extends StatefulWidget {
  State<App> createState() => AppState();
}

class AppRoutes {
  static const splash = "splash";
  static const auth = "auth";
  static const address = "address";

  static const dashboard = "dashboard";
  static const event_dashboard = "event_dashboard";

  static const settings = "settings";
  static const chat = "chat";
  static const event = "event";
}

class _AppStateProvider extends InheritedWidget {
  final AppState state;

  _AppStateProvider({this.state, child}) : super(child: child);

  @override
  bool updateShouldNotify(_AppStateProvider old) => false;
}

class AppNavigator {
  static NavigatorState of(BuildContext context) {
    return AppState.of(context).navKey.currentState;
  }
}

class AppState extends State<App> {
  static AppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_AppStateProvider) as _AppStateProvider).state;
  }

  final navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return _AppStateProvider(
      state: this,
      child: MaterialApp(
        theme: ThemeData(
          backgroundColor: Colors.transparent,
          textTheme: TextTheme(
              title: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        navigatorKey: navKey,
        initialRoute: AppRoutes.splash,
        routes: <String, WidgetBuilder>{
          AppRoutes.splash: (BuildContext context) => SplashScreen(),
          AppRoutes.auth: (BuildContext context) => AuthWidget(),
          AppRoutes.address: (BuildContext context) => AddressWidget(),
          AppRoutes.settings: (BuildContext context) => SettingsScreen(),
          AppRoutes.dashboard: (BuildContext context) => DashboardWidget(),
          AppRoutes.event_dashboard: (BuildContext context) => EventScreen(),

          /*
          Routes.settings: (BuildContext context) => SettingsScreen(),
          Routes.chat: (BuildContext context) => ChatView(chatId: 'chatIdtemp'),
          Routes.event: (BuildContext context) => EventEditScreen(),
           */
        },
      ),
    );
  }
}
