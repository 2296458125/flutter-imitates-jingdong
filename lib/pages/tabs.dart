import 'package:flutter/material.dart';
import 'classification.dart';
import 'find.dart';
import 'home.dart';
import 'shoppingCar.dart';
import 'mine.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final pageController = PageController();
  List _pageList = [
    HomePage(),
    Classification(),
    Find(),
    ShoppingCar(),
    Mine()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("京东")),
      body: PageView(
        controller: pageController,
        children: [..._pageList],
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: this._currentIndex,
          onTap: (int value) {
            setState(() {
              pageController.jumpToPage(value);
            });
          },
          iconSize: 32,
          unselectedFontSize: 16,
          selectedFontSize: 16,
          fixedColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "分类"),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: "发现"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_shopping_cart), label: "购物车"),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity), label: "我的")
          ]),
    );
  }
}
