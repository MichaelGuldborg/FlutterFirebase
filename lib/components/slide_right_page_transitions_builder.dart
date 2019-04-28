import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Offset from offscreen to the right to fully on screen.
final Animatable<Offset> _kRightMiddleTween = Tween<Offset>(
  begin: const Offset(1.0, 0.0),
  end: Offset.zero,
);

// Offset from fully on screen to offscreen to the left.
final Animatable<Offset> _kMiddleLeftTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(-1.0, 0.0),
);

class SlideRightPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Construct a [CupertinoPageTransitionsBuilder].
  const SlideRightPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideRightPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      child: child,
    );
  }
}

class SlideRightPageTransition extends StatelessWidget {
  SlideRightPageTransition({
    Key key,
    @required Animation<double> primaryRouteAnimation,
    @required Animation<double> secondaryRouteAnimation,
    @required this.child,
  })  : _primaryPositionAnimation = CurvedAnimation(
          parent: primaryRouteAnimation,
          curve: Curves.linearToEaseOut, // Mimic iOS
          reverseCurve: Curves.easeInToLinear,
        ).drive(_kRightMiddleTween),
        _secondaryPositionAnimation = CurvedAnimation(
          parent: secondaryRouteAnimation,
          curve: Curves.linearToEaseOut,
          reverseCurve: Curves.easeInToLinear,
        ).drive(_kMiddleLeftTween),
        super(key: key);

  // When this page is coming in to cover another page.
  final Animation<Offset> _primaryPositionAnimation;

  // When this page is becoming covered by another page.
  final Animation<Offset> _secondaryPositionAnimation;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    final TextDirection textDirection = Directionality.of(context);
    return SlideTransition(
      position: _secondaryPositionAnimation,
      textDirection: textDirection,
      transformHitTests: false,
      child: SlideTransition(
        position: _primaryPositionAnimation,
        textDirection: textDirection,
        child: child,
      ),
    );
  }
}
