import 'dart:developer';

import 'package:drag_and_drop/data/colors.dart';
import 'package:drag_and_drop/data/icons_data.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

final math.Random _r = math.Random();

class GameEngine with ChangeNotifier {
  static List<Icon> items = [];

  static List<Icon> generateTopRow(int numberOfItems, double iconSize) {
    items.clear();
    for (int i = 0; i < numberOfItems; i++) {
      final icon = generateRandomIcon(iconSize);
      items.add(icon);
    }
    return items;
  }
}

Icon generateRandomIcon(double iconSize) {
  final iconData = IconsData.iconData[_r.nextInt(IconsData.iconData.length)];
  return Icon(iconData, color: randomColor(), size: iconSize);
}

Color randomColor() => IconsColors.colors[_r.nextInt(IconsColors.colors.length)];
