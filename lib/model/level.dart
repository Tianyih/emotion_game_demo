import 'package:quiver/iterables.dart';
import 'array_2d.dart';
import '../panel/objective/model/objective.dart';

///
/// Level
///
/// Definition of a level in terms of:
///  - grid template
///  - duration (seconds)
///  - number of columns
///  - number of rows
///  - list of objectives
///
class Level extends Object {
  final int _index;
  late Array2d grid;
  final int _rows;
  final int _cols;
  final int _maxSeconds;
  int _secondsLeft = 0;
  late List<Objective> _objectives;

  /// Variables that depend on the physical layout of the device
  double tileWidth = 48.0;
  double tileHeight = 48.0;
  double boardLeft = 0.0;
  double boardTop = 0.0;

  Level.fromJson(Map<String, dynamic> json)
      : _index = json["level"],
        _rows = json["rows"],
        _cols = json["cols"],
        _maxSeconds = 90 {
    // Initialize the grid to the dimensions
    grid = Array2d(_rows, _cols);

    // Populate the grid from the definition
    //
    // Trick
    //  As the definition in the JSON file defines the
    //  rows (top-down) and also because we are recording
    //  the grid (bottom-up), we need to reverse the
    //  definition from the JSON file.
    //
    enumerate((json["grid"] as List).reversed).forEach((row) {
      enumerate(row.value.split(',')).forEach((cell) {
        grid[row.index][cell.index] = cell.value;
      });
    });

    // Retrieve the objectives
    _objectives = (json["objective"] as List).map((item) {
      return Objective(item);
    }).toList();

    // First-time initialization
    resetObjectives();
  }

  // @override
  // String toString() {
  //   return "level: $index \n" + dumpArray2d(grid);
  // }

  int get numberOfRows => _rows;
  int get numberOfCols => _cols;
  int get index => _index;
  int get maxSeconds => _maxSeconds;
  int get secondsLeft => _secondsLeft;

  List<Objective> get objectives => List.unmodifiable(_objectives);

  //
  // Reset the objectives
  //
  void resetObjectives() {
    for (final objective in _objectives) {
      objective.reset();
    }
    _secondsLeft = _maxSeconds;
  }

  //
  // Decrement the remaining time
  //
  int decrementSecond() {
    return (--_secondsLeft).clamp(0, _maxSeconds);
  }

  //
  // Set the remaining time
  //
  void setSecondsLeft(int seconds) {
    _secondsLeft = seconds.clamp(0, _maxSeconds);
  }
}
