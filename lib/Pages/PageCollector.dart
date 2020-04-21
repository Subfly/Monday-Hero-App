import 'package:flutter/material.dart';
import 'package:one_screen_app/Pages/AddTransportation.dart';
import 'package:one_screen_app/Pages/EmptyScreen.dart';
import 'package:one_screen_app/Themes/AppColors.dart';

class PageCollector extends StatefulWidget {
  @override
  _PageCollectorState createState() => _PageCollectorState();
}

class _PageCollectorState extends State<PageCollector> {
  int _currentIndex = 1;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          EmptyScreen(),
          AddTransportScreen(),
          EmptyScreen(),
          EmptyScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: UNSELECTED_BUTTON_COLOR,
        selectedItemColor: PRIMARY_COLOR,
        currentIndex: _currentIndex,
        elevation: 20,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _controller.animateToPage(
              _currentIndex,
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 300),
            );
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/icons/icon.png",
              ),
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/icons/hover.png",
              ),
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/icons/normal_2.png",
              ),
            ),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/icons/normal_3.png",
              ),
            ),
            title: Text(""),
          ),
        ],
      ),
    );
  }
}
