import 'package:drag_and_drop/providers/items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<ItemsRow>(create: (_) => ItemsRow()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GameBoard(),
      ),
    );
  }
}
