import 'package:breaking_bed/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  MyApp(this.router);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
    );
  }
}
