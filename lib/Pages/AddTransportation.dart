import 'package:flutter/material.dart';
import 'package:one_screen_app/Themes/AppColors.dart';
import 'package:one_screen_app/Utils/StringUtils.dart';
import 'package:one_screen_app/Widgets/AddTransportBody/AddTransportBody.dart';

class AddTransportScreen extends StatefulWidget {
  @override
  _AddTransportScreenState createState() => _AddTransportScreenState();
}

//Single ticker provider makes this widget play animations without setState() method.
class _AddTransportScreenState extends State<AddTransportScreen>
    with SingleTickerProviderStateMixin {
  //Controller for tab controller
  TabController _controller;

  /*
    Method to initialize state before execution.
    Initilaizes tab controller for the screen.
  */
  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          APP_BAR_TITLE_ADD_TRANSPORTATION,
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: PRIMARY_COLOR,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: TabBar(
              indicatorColor: ACCENT_COLOR,
              labelColor: TEXT_COLOR,
              controller: _controller,
              labelStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
              tabs: [
                Tab(
                  text: TAB_BAR_ELEMENT_IN,
                ),
                Tab(
                  text: TAB_BAR_ELEMENT_OUT,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TabBarView(
                controller: _controller,
                children: [
                  TransportInBody(),
                  TransportOutBody(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
