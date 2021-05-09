import 'package:flutter/material.dart';

class DraggableObject extends StatelessWidget {
  final Color color;
  final Icon icon;

  const DraggableObject({this.color = Colors.red, this.icon});
  @override
  Widget build(BuildContext context) {
    return Draggable(
      affinity: Axis.vertical,
      feedback: icon,
      childWhenDragging: Icon(
        icon.icon,
        size: 100,
        color: icon.color.withOpacity(0.2),
      ),
      data: icon,
      child: icon,
    );
  }
}
