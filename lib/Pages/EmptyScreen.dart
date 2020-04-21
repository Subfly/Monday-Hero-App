import 'package:flutter/material.dart';
import 'package:one_screen_app/Themes/AppColors.dart';

class EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Boş Ekran"),
        backgroundColor: PRIMARY_COLOR,
      ),
      body: Center(
        child: Text("This page is intentionally left blank."),
      ),
    );
  }
}
