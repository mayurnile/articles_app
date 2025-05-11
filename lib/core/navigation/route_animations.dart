import 'package:articles_app/core/core.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

enum AnimationType { slideRight, slideUp, slideLeft }

CustomRoute<dynamic> getAnimatedRoute({
  required PageInfo page,
  List<AutoRoute>? children,
  bool initial = false,
  List<AutoRouteGuard> guards = const [],
  AnimationType animationType = AnimationType.slideRight,
  bool fullscreenDialog = false,
}) => CustomRoute(
  page: page,
  children: children,
  initial: initial,
  barrierColor: Colors.black,
  fullscreenDialog: fullscreenDialog,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    switch (animationType) {
      case AnimationType.slideRight:
        return _cupertinoSlideAnimation(
          context,
          animation,
          secondaryAnimation,
          child,
        );
      case AnimationType.slideUp:
        return _bottomToTopAnimation(
          context,
          animation,
          secondaryAnimation,
          child,
        );
      case AnimationType.slideLeft:
        return _leftToRightAnimation(
          context,
          animation,
          secondaryAnimation,
          child,
        );
    }
  },
  durationInMilliseconds: 700,
  reverseDurationInMilliseconds: 800,
  guards: guards,
);

Widget _cupertinoSlideAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  // Offset from offscreen to the right to fully on screen.
  final Animatable<Offset> kRightMiddleTween = Tween<Offset>(
    begin: const Offset(1, 0),
    end: Offset.zero,
  );

  // Scale down to 80% from the original size
  final Animatable<double> kScaleDown = Tween<double>(begin: 1, end: 0.87);

  final primaryPositionAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.linearToEaseOut,
    reverseCurve: Curves.easeInToLinear,
  ).drive(kRightMiddleTween);

  final scaleAnimation = CurvedAnimation(
    parent: secondaryAnimation,
    curve: Curves.linearToEaseOut,
    reverseCurve: Curves.easeInToLinear,
  ).drive(kScaleDown);

  final textDirection = Directionality.of(context);

  return ScaleTransition(
    scale: scaleAnimation,
    alignment: Alignment.bottomCenter,
    child: SlideTransition(
      position: primaryPositionAnimation,
      textDirection: textDirection,
      child: child,
    ),
  );
}

Widget _bottomToTopAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  // Offset from offscreen at the bottom to fully on screen.
  final Animatable<Offset> kBottomUpTween = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  );

  final Animatable<double> kScaleDown = Tween<double>(begin: 1, end: 0.87);

  final primaryPositionAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  ).drive(kBottomUpTween);

  final scaleAnimation = CurvedAnimation(
    parent: secondaryAnimation,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  ).drive(kScaleDown);

  return ScaleTransition(
    scale: scaleAnimation,
    alignment: Alignment.bottomCenter,
    child: SlideTransition(position: primaryPositionAnimation, child: child),
  );
}

Widget _leftToRightAnimation(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final Animatable<Offset> kRightLeftTween = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: Offset.zero,
  );

  final primaryPositionAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOutCubic,
    reverseCurve: Curves.easeInOutCubic,
  ).drive(kRightLeftTween);

  return SlideTransition(position: primaryPositionAnimation, child: child);
}

CustomRoute<void> getModalBottomSheetRoute({
  required PageInfo page,
  bool initial = false,
  List<AutoRoute>? children,
  List<AutoRouteGuard> guards = const [],
}) => CustomRoute(
  page: page,
  children: children,
  initial: initial,
  fullscreenDialog: true,
  customRouteBuilder: <T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return ModalBottomSheetRoute(
      settings: page,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      modalBarrierColor: Colors.black.opacityValue(0.75),
      builder: (context) => child,
    );
  },
  transitionsBuilder: _bottomToTopAnimation,
  durationInMilliseconds: 700,
  reverseDurationInMilliseconds: 800,
  guards: guards,
);
