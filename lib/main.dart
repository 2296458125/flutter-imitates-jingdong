import 'package:flutter/material.dart';
import './router/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(primarySwatch: Colors.red),
      // ignore: missing_return
      onGenerateRoute: onGenerateRoute,
    );
  }
}
