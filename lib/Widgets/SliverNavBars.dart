import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Adaptation between CupertinoNavigationBar and AppBar
class TCupertinoSliverNav extends StatefulWidget {
  const TCupertinoSliverNav({Key? key}) : super(key: key);

  @override
  State<TCupertinoSliverNav> createState() => _TCupertinoSliverNavState();
}

class _TCupertinoSliverNavState extends State<TCupertinoSliverNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Platform.isIOS
              ? CupertinoSliverNavigationBar(
                  largeTitle: Text('Material AppBar'),
                )
              : SliverAppBar.large(
                  title: Text('Material AppBar'),
                ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text('Row $index'),
                );
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar example
class TMaterialSliverTop extends StatefulWidget {
  @override
  _TMaterialSliverTopState createState() => _TMaterialSliverTopState();
}

class _TMaterialSliverTopState extends State<TMaterialSliverTop> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar.large(
              // missing border
              // surfaceTintColor: Platform.isIOS ? Colors.transparent : null,
              // not sure if this should be hard coded or be a factor of the device
              // toolbarHeight: Platform.isIOS ? 44 : kToolbarHeight,
              // collapsedHeight: Platform.isIOS ? 44 : kToolbarHeight,
              // expandedHeight: Platform.isIOS ? 117 : null,
              title: Text('Material AppBar'),
              // shadowColor:
              //     Platform.isIOS ? CupertinoColors.darkBackgroundGray : null,
              // scrolledUnderElevation: Platform.isIOS ? .1 : null,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text('Row $index'),
                  );
                },
                childCount: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class _TMaterialSliverTopState extends State<TMaterialSliverTop> {
//   final myName = 'LeighaJarett';
//   final numTweets = '5,000';
//   final coverPhotoUrl =
//       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';
//   final profileUrl =
//       'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg';
//   final _tabBar = TabBar(
//       unselectedLabelColor: CupertinoColors.systemGrey,
//       labelColor: CupertinoColors.label,
//       labelStyle: CupertinoThemeData()
//           .textTheme
//           .navTitleTextStyle
//           .copyWith(fontSize: 15),
//       tabs: [
//         Tab(text: 'Tweets'),
//         Tab(text: 'Replies'),
//         Tab(text: 'Media'),
//         Tab(text: 'Likes')
//       ]);

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Scaffold(
//         body: DefaultTabController(
//       length: 4,
//       child: CustomScrollView(
//         physics: const BouncingScrollPhysics(),
//         slivers: [
//           SliverAppBar.large(
//             leading: CustomIconButton(
//                 icon: Icons.arrow_back,
//                 onPressed: () => Navigator.pop(context)),
//             actions: [
//               CustomIconButton(icon: Icons.search, onPressed: () {}),
//             ],

//             bottom: PreferredSize(
//                 preferredSize: _tabBar.preferredSize,
//                 child: ColoredBox(
//                   color: Colors.white,
//                   child: _tabBar,
//                 )),
//             stretch: true,
//             // floating: true,
//             // snap: true,
//             pinned: true,
//             expandedHeight: 400.0,
//             title: Column(
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(myName),
//                 Text(
//                   numTweets + ' Tweets',
//                   style: TextStyle(fontSize: 12, color: Colors.black),
//                   textAlign: TextAlign.left,
//                 )
//               ],
//             ),
//             // flexibleSpace: FlexibleSpaceBar(
//             //   collapseMode: CollapseMode.parallax,
//             //   title: LayoutBuilder(builder: (context, constraints) {
//             //     print(Scrollable.of(context).position.pixels);
//             //     print(constraints.maxHeight);
//             //     return Center(
//             //       child: constraints.maxHeight < 170
//             //           ? Column(
//             //               mainAxisAlignment: MainAxisAlignment.center,
//             //               children: [
//             //                 Text(myName),
//             //                 Text(
//             //                   numTweets + ' Tweets',
//             //                   style: TextStyle(fontSize: 12),
//             //                   textAlign: TextAlign.left,
//             //                 )
//             //               ],
//             //             )
//             //           : Container(),
//             //     );
//             //   }),
//             //   centerTitle: true,
//             //   stretchModes: <StretchMode>[
//             //     StretchMode.zoomBackground,
//             //     StretchMode.blurBackground,
//             //   ],
//             //   background: Stack(
//             //     fit: StackFit.expand,
//             //     children: <Widget>[
//             //       Image.network(
//             //         coverPhotoUrl,
//             //         fit: BoxFit.fitWidth,
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return ListTile(
//                   title: Text('Row $index'),
//                 );
//               },
//               childCount: 100,
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// class CustomIconButton extends StatelessWidget {
//   CustomIconButton({
//     Key? key,
//     required this.icon,
//     required this.onPressed,
//   }) : super(key: key);

//   final IconData icon;
//   final VoidCallback onPressed;
//   final buttonStyle = ElevatedButton.styleFrom(
//     padding: EdgeInsets.all(0),
//     shape: CircleBorder(),
//     backgroundColor: Colors.black.withOpacity(.5), // <-- Button color
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: 30,
//         height: 30,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           child: Icon(
//             icon,
//             color: Colors.white,
//             size: 18,
//           ),
//           style: buttonStyle,
//         ),
//       ),
//     );
//   }
// }
