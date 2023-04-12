import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TCupertinoDialog extends StatelessWidget {
  const TCupertinoDialog({Key? key}) : super(key: key);

  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  // TO DO: Add adaptation
  @override
  Widget build(BuildContext context) {
    // Button that makes a cupertino dialog popup
    return CupertinoButton(
      child: Text('Cupertino Dialog'),
      onPressed: () => _showAlertDialog(context),
    );
  }
}

class TMaterialDialog extends StatelessWidget {
  const TMaterialDialog({Key? key}) : super(key: key);

  void _showDialog(BuildContext context) {
    showDialog<String>(
        barrierColor: CupertinoColors.systemGrey.withOpacity(0.4),
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: CupertinoColors.systemBackground,
              // surfaceTintColor: CupertinoColors.systemGrey,
              elevation: 0,
              title: const Text('AlertDialog Title'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('This is a demo alert dialog.'),
                    Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )

        // backgroundColor: CupertinoColors.systemBackground,
        // surfaceTintColor: CupertinoColors.systemGrey,
        // shadowColor: Colors.transparent,
        // elevation: 1,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10),
        // ),
        // // backgroundColor: CupertinoColors.systemBackground,
        // child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Padding(
        //         padding: const EdgeInsets.all(15.0),
        //         child: Text('Important message',
        //             style: CupertinoThemeData().textTheme.navTitleTextStyle),
        //       ),
        //       Container(
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           border: Border(
        //             top: BorderSide(
        //               color: CupertinoColors.systemGrey,
        //               style: BorderStyle.solid,
        //             ),
        //           ),
        //         ),
        //         child: TextButton(
        //           onPressed: () {
        //             Navigator.pop(context);
        //           },
        //           child: Text('OK',
        //               style: CupertinoThemeData()
        //                   .textTheme
        //                   .navTitleTextStyle
        //                   .copyWith(color: CupertinoColors.activeBlue)),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => _showDialog(context), child: Text("Material Dialog"));
  }
}
