import 'package:drag_and_drop/data/colors.dart';
import 'package:drag_and_drop/data/icons_data.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

final math.Random _r = math.Random();
final gameEngineProvider = ChangeNotifierProvider((ref) => GameEngine());

class GameEngine with ChangeNotifier {
  List<Icon> items = [];

  List<Icon> generateTopRow(int numberOfItems, double iconSize) {
    items.clear();
    for (int i = 0; i < numberOfItems; i++) {
      final icon = generateRandomIcon(iconSize);
      items.add(icon);
    }
    notifyListeners();
    return items;
  }
}

Icon generateRandomIcon(double iconSize) {
  final iconData = IconsData.iconData[_r.nextInt(IconsData.iconData.length)];
  return Icon(iconData, color: randomColor(), size: iconSize);
}

Color randomColor() => IconsColors.colors[_r.nextInt(IconsColors.colors.length)];
