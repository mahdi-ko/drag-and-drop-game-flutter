import 'package:drag_and_drop/draggable_list.dart';
import 'package:drag_and_drop/icon_drag_target.dart';
import 'package:drag_and_drop/providers/game_engine.dart';
import 'package:drag_and_drop/providers/items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<Icon> draggableIcons = [];
  List<Item> targetItems = [];
  ItemsRow itemsRow;

  @override
  void initState() {
    draggableIcons = GameEngine.generateTopRow(10, 100);
    itemsRow = Provider.of<ItemsRow>(context, listen: false);
    itemsRow.generateIconsRow(10, 2, 100);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Game Board'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            child: DraggableList(
              items: draggableIcons,
            ),
          ),
          for (int j = 0; j < itemsRow.itemsRow.length; j++) ...[
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: itemsRow.itemsRow[j].length,
                itemBuilder: (ct, i) {
                  return ChangeNotifierProvider.value(
                    value: itemsRow.itemsRow[j][i],
                    builder: (c, child) {
                      return IconDragTarget();
                    },
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
