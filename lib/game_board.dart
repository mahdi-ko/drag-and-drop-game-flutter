import 'dart:developer';

import 'package:drag_and_drop/draggable_list.dart';
import 'package:drag_and_drop/providers/game_engine.dart';
import 'package:drag_and_drop/providers/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'icon_drag_target_list.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  List<Icon> draggableIcons = [];
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      initGameData();
    });
    super.initState();
  }

  initGameData() {
    draggableIcons = context.read(gameEngineProvider).generateTopRow(8, 100);

    final itemsRow = context.read(itemsProvider);
    itemsRow.generateIconsRow(10, 4, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Text("Reset"),
        onPressed: initGameData,
      ),
      appBar: AppBar(
        title: Text('Game Board'),
      ),
      body: Consumer(builder: (context, watch, child) {
        final itemsRow = watch(itemsProvider);
        log(itemsRow.itemsRow.length.toString());
        return Column(
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
                child: IconDragTargetList(
                  items: itemsRow.itemsRow[j],
                  key: Key(itemsRow.idTracker.toString()),
                ),
              ),
            ]
          ],
        );
      }),
    );
  }
}
