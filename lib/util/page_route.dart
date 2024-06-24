import 'package:flutter/material.dart';

class SwipePageRoute<T> extends PageRouteBuilder<T> {
  SwipePageRoute({
    required this.builder,
    this.currentChild,
    required this.routeAnimation,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            Widget buildSlideTransitionWithTween(
              Offset begin,
              Widget child, [
              Offset end = const Offset(0, 0),
            ]) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: begin,
                  end: end,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.linear,
                  ),
                ),
                child: child,
              );
            }

            switch (routeAnimation) {
              case RouteAnimation.verticalReverse:
                return Stack(
                  children: <Widget>[
                    buildSlideTransitionWithTween(
                      const Offset(0.0, -1.0),
                      child,
                    ),
                    buildSlideTransitionWithTween(
                      const Offset(0.0, 0.0),
                      currentChild!,
                      const Offset(0.0, 1.0),
                    ),
                  ],
                );

              case RouteAnimation.vertical:
                return Stack(
                  children: <Widget>[
                    buildSlideTransitionWithTween(
                      const Offset(0.0, 1.0),
                      child,
                    ),
                    buildSlideTransitionWithTween(
                      const Offset(0.0, 0.0),
                      currentChild!,
                      const Offset(0.0, -1.0),
                    ),
                  ],
                );

              case RouteAnimation.horizontalReverse:
                return Stack(
                  children: <Widget>[
                    buildSlideTransitionWithTween(
                      const Offset(-1.0, 0.0),
                      child,
                    ),
                    buildSlideTransitionWithTween(
                      const Offset(0.0, 0.0),
                      currentChild!,
                      const Offset(1.0, 0.0),
                    ),
                  ],
                );

              case RouteAnimation.horizontal:
                return Stack(
                  children: <Widget>[
                    buildSlideTransitionWithTween(
                      const Offset(1.0, 0.0),
                      child,
                    ),
                    buildSlideTransitionWithTween(
                      const Offset(0.0, 0.0),
                      currentChild!,
                      const Offset(-1.0, 0.0),
                    ),
                  ],
                );

              default:
                return child;
            }
          },
        );

  final WidgetBuilder builder;

  final Widget? currentChild;

  final RouteAnimation routeAnimation;
}

enum RouteAnimation {
  verticalReverse,
  vertical,
  horizontalReverse,
  horizontal,
}
