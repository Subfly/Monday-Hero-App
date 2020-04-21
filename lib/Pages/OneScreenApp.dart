import 'package:flutter/material.dart';
import 'package:one_screen_app/Pages/PageCollector.dart';

class OneScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Lato",
      ),
      home: PageCollector(),
    );
  }
}
