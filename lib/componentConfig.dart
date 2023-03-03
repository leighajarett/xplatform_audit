import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/AppBars.dart';
import 'Widgets/TabBars.dart';
import 'Widgets/Dialogs.dart';

Map<String, WidgetConfig> widgetMap = {
  'Top App Bar': WidgetConfig(
    cupertino: TCupertinoAppBar(),
    material: TMaterialAppBar(),
    swift: 'AppBar',
  ),
  'Bottom Tab Bar': WidgetConfig(
    cupertino: TCupertinoTabBar(),
    material: TMaterialTabBar(),
    swift: 'AppBar',
  ),
  'Dialog': WidgetConfig(
    cupertino: TCupertinoDialog(),
    material: TMaterialDialog(),
    swift: 'Dialog',
  ),
};

class WidgetConfig {
  Widget cupertino;
  Widget material;
  String swift;
  WidgetConfig(
      {required this.cupertino, required this.material, required this.swift});
}
