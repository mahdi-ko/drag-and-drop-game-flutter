import 'dart:developer';

import 'package:drag_and_drop/providers/items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconDragTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);

    return DragTarget(
      onWillAccept: (droppedItem) {
        if (droppedItem is Icon &&
            item.color == droppedItem.color &&
            item.icon == droppedItem.icon &&
            item.size == droppedItem.size) {
          log("true");

          return true;
        }
        log("false");

        return false;
      },
      onAccept: (_) {
        item.isEmpty = true;
      },
      builder: (_, acceptedItems, ___) {
        return Icon(
          item.icon,
          color: item.color.withOpacity(0.2),
          size: item.size,
        );
      },
    );
  }
}
