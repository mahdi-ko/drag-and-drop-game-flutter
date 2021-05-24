import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'game_engine.dart';
import 'dart:math' as math;

final math.Random _r = math.Random();

final itemsProvider = ChangeNotifierProvider<ItemsRow>((ref) {
  final engine = ref.watch(gameEngineProvider);
  return ItemsRow(engine);
});

class Item with ChangeNotifier {
  int _id;
  Color _color;
  IconData _icon;
  bool _isEmpty;
  double _size;
  Item(this._id, this._color, this._icon, this._isEmpty, this._size);

  int get id => _id;
  Color get color => _color;
  IconData get icon => _icon;
  bool get isEmpty => _isEmpty;
  double get size => _size;

  set color(Color c) {
    _color = c;
    notifyListeners();
  }

  set icon(IconData i) {
    _icon = i;
    notifyListeners();
  }

  set isEmpty(bool b) {
    _isEmpty = b;
    notifyListeners();
  }

  set size(double d) {
    _size = d;
    notifyListeners();
  }
}

class ItemsRow with ChangeNotifier {
  final GameEngine gameEngine;
  Map<int, List<Item>> _itemsRow = {};

  ItemsRow(this.gameEngine);
  Map<int, List<Item>> get itemsRow => _itemsRow;
  int _idTracker = 0;

  int get idTracker {
    _idTracker++;
    return _idTracker;
  }

  void generateIconsRow(int numOfRows, int numOfCols, double iconSize) {
    Map<int, List<Item>> items = {};
    for (int j = 0; j < numOfCols; j++) {
      int randomizedNum = _r.nextInt(numOfRows);
      final count = randomizedNum >= 3 ? randomizedNum : _r.nextInt(numOfRows) + 3;
      for (int i = 0; i < count; i++) {
        final icon = _generateIconOnValidOnes(iconSize);
        if (items[j] == null) items[j] = [];
        items[j].add(Item(idTracker, icon.color, icon.icon, true, iconSize));
      }
    }
    _itemsRow = items;
    notifyListeners();
  }

  void clearRow() {
    _itemsRow.clear();
    notifyListeners();
  }

  void removeItem(int col, int index) {
    itemsRow[col].remove(index);
    notifyListeners();
  }

  Icon _generateIconOnValidOnes(double iconSize) {
    final icon = gameEngine.items[_r.nextInt(gameEngine.items.length)];
    return Icon(icon.icon, color: icon.color, size: iconSize);
  }
}
