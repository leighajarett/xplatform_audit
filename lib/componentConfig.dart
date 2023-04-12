import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/AppBars.dart';
import 'Widgets/SliverNavBars.dart';
import 'Widgets/TabBars.dart';
import 'Widgets/Dialogs.dart';

Map<String, WidgetConfig> widgetMap = {
  'Top App Bar': WidgetConfig(
    cupertino: TCupertinoAppBar(),
    material: TMaterialAppBar(),
  ),
  'Sliver Top App Bar': WidgetConfig(
    cupertino: TCupertinoSliverNav(),
    material: TMaterialSliverTop(),
  ),
  'Bottom Tab Bar': WidgetConfig(
    cupertino: TCupertinoTabBar(),
    material: TMaterialTabBar(),
  ),
  'Alert Dialog': WidgetConfig(
    cupertino: TCupertinoDialog(),
    material: TMaterialDialog(),
  ),
};

class WidgetConfig {
  Widget cupertino;
  Widget material;
  WidgetConfig({
    required this.cupertino,
    required this.material,
  });
}
