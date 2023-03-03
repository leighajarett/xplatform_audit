// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_ios/Widgets/AppBars.dart';
import 'Widgets/TabBars.dart';

import 'componentConfig.dart';

// const EventChannel _platformEventChannel =
//     const EventChannel('overlay_ios.flutter.io/responder');
const platform = MethodChannel('overlay_ios.flutter.io/overlay');

TextTheme cupertinoTextTheme = TextTheme(
  titleLarge: CupertinoThemeData().textTheme.navLargeTitleTextStyle,
  titleMedium: CupertinoThemeData().textTheme.navTitleTextStyle,
  // headlineLarge: CupertinoThemeData().textTheme.navLargeTitleTextStyle,
  // headlineMedium: CupertinoThemeData().textTheme.navTitleTextStyle,
  // headlineSmall: CupertinoThemeData().textTheme.navActionTextStyle,
  // displayMedium: CupertinoThemeData().textTheme.textStyle,
);

ColorScheme cupertinoColorScheme = ColorScheme.fromSwatch(
  backgroundColor: CupertinoThemeData().scaffoldBackgroundColor,
  // primarySwatch: Colors.blue,
  primaryColorDark: CupertinoThemeData().primaryColor,
);

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      home: ParentScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: Platform.isIOS ? cupertinoColorScheme : null,
        textTheme: Platform.isIOS ? cupertinoTextTheme : null,
      ),
    ),
  );
}

class ParentScreen extends StatefulWidget {
  const ParentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  String? _componentName;
  List<bool> _isSelected = [true, false];
  bool _showSwift = false;

  void onSwitchChanged(bool value) {
    try {
      platform.invokeMethod('switchChanged',
          {"show_swiftui": value, "component": _componentName});
    } on PlatformException catch (e) {
      print("Failed to send switch change");
    }
    setState(() {
      _showSwift = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var displayWidget = _componentName == null
        ? Text('Select a widget')
        : _isSelected[1]
            ? widgetMap[_componentName]?.cupertino
            : widgetMap[_componentName]?.material;

    return Scaffold(
      appBar: CupertinoNavigationBar(
          heroTag: "main nav bar",
          transitionBetweenRoutes: false,
          leading: Text('X-Platform Playground')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _componentName,
                  items: widgetMap.keys
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _componentName = newValue;
                    });
                  },
                ),
                ToggleButtons(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Material3'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Adaptive'),
                    ),
                  ],
                  isSelected: _isSelected,
                  onPressed: (int index) {
                    setState(() {
                      _isSelected = [false, false];
                      _isSelected[index] = true;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: _componentName == "Bottom Tab Bar"
                  ? Text("Must use full screen")
                  : displayWidget,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FullScreen(
                          displayWidget: displayWidget,
                          componentName: _componentName,
                          material: _isSelected[0],
                        ),
                      ),
                    );
                  },
                  child: Text('Open in new screen'),
                ),
                Column(
                  children: [
                    Text(
                      'Show SwiftUI',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Switch.adaptive(
                      value: _showSwift,
                      onChanged:
                          _componentName == null ? null : onSwitchChanged,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FullScreen extends StatelessWidget {
  Widget? displayWidget;
  String? componentName;
  bool material;

  FullScreen(
      {Key? key,
      required this.componentName,
      required this.displayWidget,
      required this.material})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (componentName == 'Top App Bar') {
      return material ? FSTMaterialAppBar() : FSTCupertinoAppBar();
    } else if (componentName == 'Bottom Tab Bar' && displayWidget != null) {
      return displayWidget!;
    }
    return Scaffold(
      body: displayWidget,
    );
  }
}
