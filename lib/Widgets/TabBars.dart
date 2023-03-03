import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Adaptation between CupertinoNavigationBar and AppBar
class TCupertinoTabBar extends StatefulWidget {
  const TCupertinoTabBar({Key? key}) : super(key: key);

  @override
  State<TCupertinoTabBar> createState() => _TCupertinoTabBarState();
}

class _TCupertinoTabBarState extends State<TCupertinoTabBar> {
  Widget _currentWidget = Container();
  var _currentIndex = 0;

  Widget _homeScreen() {
    return Center(
      child: Text('Home Screen'),
    );
  }

  Widget _settingsScreen() {
    return Center(
      child: Text('Settings Screen'),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  void _loadScreen() {
    switch (_currentIndex) {
      case 0:
        return setState(() => _currentWidget = _homeScreen());
      case 1:
        return setState(() => _currentWidget = _settingsScreen());
    }
  }

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: Platform.isIOS ? Icon(CupertinoIcons.home) : Icon(Icons.home),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.adaptive.share), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _currentWidget,
        bottomNavigationBar: Platform.isIOS
            ? CupertinoTabBar(
                border: Border.all(color: Colors.transparent),
                backgroundColor: CupertinoThemeData().scaffoldBackgroundColor,
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                  _loadScreen();
                },
                items: _items,
              )
            : BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() => _currentIndex = index);
                  _loadScreen();
                },
                items: _items,
              ));
  }
}

// Bottom Navigation Bar example
class TMaterialTabBar extends StatefulWidget {
  @override
  _TMaterialTabBarState createState() => _TMaterialTabBarState();
}

class _TMaterialTabBarState extends State<TMaterialTabBar> {
  Widget _currentWidget = Container();
  var _currentIndex = 0;

  Widget _homeScreen() {
    return Center(
      child: Text('Home Screen'),
    );
  }

  Widget _settingsScreen() {
    return Center(
      child: Text('Settings Screen'),
    );
  }

  void _loadScreen() {
    switch (_currentIndex) {
      case 0:
        return setState(() => _currentWidget = _homeScreen());
      case 1:
        return setState(() => _currentWidget = _settingsScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentWidget,
      bottomNavigationBar: BottomNavigationBar(
        // remove elevation, but have no way to control the animation of the taps
        elevation: Platform.isIOS ? 0 : null,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          _loadScreen();
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Platform.isIOS ? CupertinoIcons.home : Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.adaptive.share), label: 'Settings'),
        ],
      ),
    );
  }
}
