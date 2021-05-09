import 'dart:math';

import 'package:drag_and_drop/data/colors.dart';
import 'package:drag_and_drop/data/icons_data.dart';
import 'package:drag_and_drop/draggable_list.dart';
import 'package:drag_and_drop/draggable_object.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final Random r = Random();
  List<Widget> items;
  Widget item;
  @override
  void initState() {
    item = Container(
      color: Colors.black,
      height: 100,
      width: 100,
    );
    items = generateGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Transform Demo'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            child: DraggableList(
              items: items,
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DraggableObject(
                  icon: randomIcon(),
                ),
                DragTarget(
                  onWillAccept: (_) {
                    return true;
                  },
                  onAccept: (_) {
                    setState(() {
                      item = _;
                    });
                  },
                  builder: (_, acceptedItems, ___) {
                    return item;
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> generateGame() {
    final count = r.nextInt(15) + 5;
    List<Icon> items = [];
    for (int i = 0; i < count; i++) items.add(randomIcon());
    return items;
  }

  Icon randomIcon() => Icon(iconData[r.nextInt(iconData.length)], color: randomColor(), size: 100);

  Color randomColor() => colors[r.nextInt(colors.length)];
}
