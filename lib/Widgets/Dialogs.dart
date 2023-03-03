import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCupertinoDialog extends StatelessWidget {
  const TCupertinoDialog({Key? key}) : super(key: key);

  // TO DO: Add adaptation
  @override
  Widget build(BuildContext context) {
    return const CupertinoNavigationBar(
      middle: Text('Cupertino Navigation Dialog'),
    );
  }
}

class TMaterialDialog extends StatelessWidget {
  const TMaterialDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Material Like Cupertino Dialog',
          style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
      backgroundColor: CupertinoTheme.of(context).barBackgroundColor,
    );
  }
}
