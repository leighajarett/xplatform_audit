import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

var list = ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('Item $index'),
    );
  },
);

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
class FSTCupertinoAppBar extends StatelessWidget {
  const FSTCupertinoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          'Cupertino Navigation Bar',
        ),
      ),
      body: list,
    );

    // Can't adapt because of API differences
    // Scaffold(appBar:  Platform.isIOS
    //     ? CupertinoNavigationBar(
    //         middle: Text('Cupertino Navigation Bar'),
    //       )
    //     : AppBar(
    //         title: Text('Material Navigation Bar'),
    //       ),
    //       body: list
    //       )
  }
}

// Full Screen Adaptation Adaptation between themed AppBars
class FSTMaterialAppBar extends StatelessWidget {
  const FSTMaterialAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: list,
      appBar: AppBar(
        surfaceTintColor: Platform.isIOS ? Colors.transparent : null,
        shadowColor: Platform.isIOS ? CupertinoColors.darkBackgroundGray : null,
        scrolledUnderElevation: Platform.isIOS ? .1 : null,
        toolbarHeight: Platform.isIOS ? 44 : null,
        title: Text(
          'My AppBar',
        ),
      ),
    );
  }
}


        // Platform.isIOS
        //     ? CupertinoTheme.of(context).barBackgroundColor.withOpacity(.97)
        //     : null,
        // For making it semitransparent to see the background
        // elevation: 0,
        // backgroundColor: Colors.transparent,

        // BackButton is already used in leading by default
        // Would be nice to be able to customize the back icon used
        // leading: BackButton(
        //     // Make correct color
        //     // color: Platform.isIOS ? Theme.of(context).primaryColor : null,
        //     ),