import 'dart:developer';

import 'package:drag_and_drop/providers/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconDragTarget extends StatefulWidget {
  final Item item;
  IconDragTarget(this.item);

  @override
  _IconDragTargetState createState() => _IconDragTargetState();
}

class _IconDragTargetState extends State<IconDragTarget> {
  ChangeNotifierProvider<Item> singleItemProvider;
  @override
  void initState() {
    singleItemProvider = ChangeNotifierProvider<Item>((ref) {
      return widget.item;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onWillAccept: (droppedItem) {
        if (droppedItem is Icon &&
            widget.item.color == droppedItem.color &&
            widget.item.icon == droppedItem.icon &&
            widget.item.size == droppedItem.size) {
          log("true");
          return true;
        }
        log("false");

        return false;
      },
      onAccept: (_) {
        context.read(singleItemProvider).isEmpty = false;
      },
      builder: (_, acceptedItems, ___) {
        return Consumer(builder: (context, watch, child) {
          final item = watch(singleItemProvider);
          return Icon(
            item.icon,
            color: item.color.withOpacity(item.isEmpty ? 0.2 : 1),
            size: item.size,
          );
        });
      },
    );
  }
}
