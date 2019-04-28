import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/screens/address/address_widget.dart';
import 'package:flutter_firebase_app/screens/auth/auth_widget.dart';
import 'package:flutter_firebase_app/screens/basic/app_error_widget.dart';
import 'package:flutter_firebase_app/screens/basic/overview_widget.dart';
import 'package:flutter_firebase_app/screens/basic/splash_widget.dart';
import 'package:flutter_firebase_app/screens/chat/chat_screen.dart';
import 'package:flutter_firebase_app/screens/dashboard/dashboard_widget.dart';
import 'package:flutter_firebase_app/screens/event/event_edit_screen.dart';
import 'package:flutter_firebase_app/screens/event/event_screen.dart';
import 'package:flutter_firebase_app/screens/settings/settings_screen.dart';

void main() => runApp(App());

// https://stackoverflow.com/questions/53672171/how-to-get-build-and-version-number-of-flutter-app

class App extends StatefulWidget {
  State<App> createState() => AppState();
}

class AppRoutes {
  static const splash = "splash";
  static const auth = "auth";

  static const overview = "overview";

  // Minejendom
  static const address = "address";
  static const dashboard = "dashboard";
  static const settings = "settings";

  // Sidecourt
  static const event_dashboard = "event_dashboard";
  static const event = "event";

  // Other
  static const chat = "chat";
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
        onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
            builder: (BuildContext context) => AppErrorWidget(
                  message: "The app route \"${settings.name}\" could not be found",
                )),
        routes: <String, WidgetBuilder>{
          AppRoutes.splash: (BuildContext context) => SplashWidget(),
          AppRoutes.auth: (BuildContext context) => AuthWidget(),
          AppRoutes.overview: (BuildContext context) => OverviewWidget(),

          // Minejendom
          AppRoutes.address: (BuildContext context) => AddressWidget(),
          AppRoutes.dashboard: (BuildContext context) => DashboardWidget(),
          AppRoutes.settings: (BuildContext context) => SettingsScreen(),

          // Sidecourt
          AppRoutes.event_dashboard: (BuildContext context) => EventScreen(),
          AppRoutes.event: (BuildContext context) => EventEditScreen(),

          // Others
          AppRoutes.chat: (BuildContext context) => ChatView(chatId: 'chatIdtemp'),
        },
      ),
    );
  }
}
