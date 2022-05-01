import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {

  final Widget page;

  CustomRoute({required this.page}) : super(
    pageBuilder: (
        BuildContext context,
        Animation primaryAnimation,
        Animation secondaryAnimation,
        ) => page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> primaryAnimation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return SharedAxisTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.scaled, //Means, Along z axis
        child: child,
      );
    },
  );
}