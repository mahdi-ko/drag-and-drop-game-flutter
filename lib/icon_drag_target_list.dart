import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import 'icon_drag_target.dart';
import 'providers/items.dart';

class IconDragTargetList extends StatefulWidget {
  IconDragTargetList({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<Item> items;

  @override
  _IconDragTargetListState createState() => _IconDragTargetListState();
}

class _IconDragTargetListState extends State<IconDragTargetList> {
  final ScrollController sc = ScrollController();
  bool go = true;
  double width;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  void scrollIt(DragTargetDetails<dynamic> details) {
    if (go) {
      go = false;
      if (details.offset.dx < 40) {
        sc.animateTo(sc.offset - 120, duration: Duration(milliseconds: 300), curve: Curves.ease);
      } else if (details.offset.dx > width - 120) {
        sc.animateTo(sc.offset + 120, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        go = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Random r = Random();
    return DragTarget(
      onMove: scrollIt,
      builder: (_, __, ___) {
        return ListView.builder(
          key: widget.key,
          scrollDirection: Axis.horizontal,
          controller: sc,
          itemCount: widget.items.length,
          itemBuilder: (ct, i) {
            return IconDragTarget(widget.items[i]);
          },
        );
      },
    );
  }
}
