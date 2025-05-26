import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScaleFadeTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.easeOutBack, // Fallback if curve is null
    );

    return ScaleTransition(
      scale: curvedAnimation,
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}
