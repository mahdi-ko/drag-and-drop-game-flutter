import 'package:drag_and_drop/draggable_object.dart';
import 'package:flutter/material.dart';

class DraggableList extends StatefulWidget {
  final List<Icon> items;

  const DraggableList({@required this.items});
  @override
  _DraggableListState createState() => _DraggableListState();
}

class _DraggableListState extends State<DraggableList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.items.map((icon) {
          return DraggableObject(icon: icon);
        }).toList(),
        scrollDirection: Axis.horizontal);
  }
}
