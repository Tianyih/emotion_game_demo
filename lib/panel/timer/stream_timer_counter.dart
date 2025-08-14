import 'package:flutter/material.dart';

import '../../bloc/bloc_provider.dart';
import '../../bloc/game_bloc.dart';

///
/// StreamTimeCounter
///
/// Displays the remaining time for the game.
/// Listens to the "timeLeft" stream.
///
class StreamTimeCounter extends StatelessWidget {
  const StreamTimeCounter({super.key});

  @override
  Widget build(BuildContext context) {
    GameBloc gameBloc = BlocProvider.of<GameBloc>(context)!.bloc;
    return StreamBuilder<int>(
      initialData: gameBloc.gameController.level.maxSeconds,
      stream: gameBloc.timeLeft,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        final int seconds = snapshot.data ?? 0;
        final String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
        final String secondsStr = (seconds % 60).toString().padLeft(2, '0');
        final Color color = seconds <= 10 ? Colors.red : Colors.white;

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.timer,
              color: color, // Icon color changes based on remaining time
              size: 50.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              '$minutesStr:$secondsStr',
              style: TextStyle(
                fontFamily: 'ICELAND',
                color: color,
                fontSize: 80.0,
              ),
            ),
          ],
        );
      },
    );
  }
}
