import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Adaptation between CupertinoNavigationBar and AppBar
class TCupertinoAppBar extends StatelessWidget {
  const TCupertinoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            heroTag: "sandbox cupertino nav bar",
            transitionBetweenRoutes: false,
            middle: Text('Cupertino Navigation Bar'),
          )
        : AppBar(
            title: Text('Material App Bar'),
          );
  }
}

// Adaptation between themed AppBars
class TMaterialAppBar extends StatelessWidget {
  const TMaterialAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? AppBar(
            title: Text('Material AppBar',
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
            backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
          )
        : AppBar(
            title: Text('Material AppBar'),
          );
  }
}

// Full Screen Adaptation between CupertinoNavigationBar and AppBar
class FSTCupertinoAppBar extends StatefulWidget {
  const FSTCupertinoAppBar({Key? key}) : super(key: key);

  @override
  State<FSTCupertinoAppBar> createState() => _FSTCupertinoAppBarState();
}

class _FSTCupertinoAppBarState extends State<FSTCupertinoAppBar> {
  bool _isLarge = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: _isLarge
            ? null
            : Text(
                'Cupertino Navigation Bar',
              ),
        leading: _isLarge
            ? Text(
                'Cupertino Navigation Bar',
                style:
                    CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              )
            : null,
      ),
      body: ElevatedButton(
        child: Text("Change title"),
        onPressed: () {
          setState(() {
            _isLarge = !_isLarge;
          });
        },
      ),
    );
    // Can't adapt because of API differences
    // Scaffold(appBar:  Platform.isIOS
    //     ? CupertinoNavigationBar(
    //         middle: Text('Cupertino Navigation Bar'),
    //       )
    //     : AppBar(
    //         title: Text('Material Navigation Bar'),
    //       ),
    //       body: Container()
    //       )
  }
}

// Full Screen Adaptation Adaptation between themed AppBars
class FSTMaterialAppBar extends StatefulWidget {
  const FSTMaterialAppBar({Key? key}) : super(key: key);

  @override
  State<FSTMaterialAppBar> createState() => _FSTMaterialAppBarState();
}

class _FSTMaterialAppBarState extends State<FSTMaterialAppBar> {
  bool _isLarge = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Material AppBar',
          style: !_isLarge && Platform.isIOS
              ? CupertinoTheme.of(context).textTheme.navTitleTextStyle
              : null,
        ),
      ),
      body: ElevatedButton(
        child: Text("Change title"),
        onPressed: () {
          setState(() {
            _isLarge = !_isLarge;
          });
        },
      ),
    );
  }
}
