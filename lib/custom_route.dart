// import 'package:flutter/material.dart';
//
// import 'login_page.dart';
//
// class FadePageRoute<T> extends MaterialPageRoute<T> {
//   FadePageRoute({
//     required WidgetBuilder builder,
//     RouteSettings? settings,
//   }) : super(
//     builder: builder,
//     settings: settings,
//   );
//
//   @override
//   Duration get transitionDuration => const Duration(milliseconds: 600);
//
//   @override
//   Widget buildTransitions(
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child,
//       ) {
//     if (settings.name == LoginScreen.routeName) {
//       return child;
//     }
//
//     return FadeTransition(
//       opacity: animation,
//       child: child,
//     );
//   }
// }