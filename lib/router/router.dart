import 'package:flutter/material.dart';
import '../pages/tabs.dart';
import '../pages/classification.dart';
import '../pages/find.dart';
import '../pages/shoppingCar.dart';
import '../pages/mine.dart';

final routes = {
  '/': (context) => Tabs(),
  '/classification': (context) => Classification(),
  '/find': (context) => Find(),
  '/shoppingCar': (context) => ShoppingCar(),
  '/mine': (context) => Mine(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
