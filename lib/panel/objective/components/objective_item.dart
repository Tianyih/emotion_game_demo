import 'package:flutter/material.dart';

import '../../../model/level.dart';
import '../../../model/tile.dart';
import '../model/objective.dart';

class ObjectiveItem extends StatelessWidget {
  const ObjectiveItem({
    super.key,
    required this.objective,
    required this.level,
  });

  final Objective objective;
  final Level level;

  @override
  Widget build(BuildContext context) {
    //
    // Trick to get the image of the tile
    //
    Tile tile = Tile(type: objective.type, level: level);
    tile.build();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 42.0,
          height: 42.0,
          child: tile.widget,
        ),
        Text('${objective.count}',
            style: TextStyle(color: Colors.blue[700], fontSize: 30.0)),
      ],
    );
  }
}
