import 'package:candycrush/panel/timer/stream_timer_counter.dart';
import 'package:flutter/material.dart';

import 'package:candycrush/bloc/bloc_provider.dart';
import 'package:candycrush/bloc/game_bloc.dart';

import '../../model/level.dart';

class GameTimerPanel extends StatelessWidget {
  const GameTimerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final GameBloc gameBloc = BlocProvider.of<GameBloc>(context)!.bloc;
    final Level level = gameBloc.gameController.level;
    final Orientation orientation = MediaQuery.of(context).orientation;
    final EdgeInsets paddingTop = EdgeInsets.only(
        top: (orientation == Orientation.portrait ? 10.0 : 0.0));

    return Padding(
      padding: paddingTop,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Level: ${level.index}',
                style: const TextStyle(
                  fontFamily: 'ICELAND',
                  fontSize: 60.0, // 增大字体
                  color: Colors.white,
                )),
          ),
          const StreamTimeCounter(),
        ],
      ),
    );
  }
}
