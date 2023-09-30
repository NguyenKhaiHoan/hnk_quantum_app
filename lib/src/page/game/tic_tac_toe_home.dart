import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/controller/game_controller.dart';
import 'package:quantum_app_summer_2023/src/page/game/tic_tac_toe_welcome.dart';
import 'package:unicons/unicons.dart';

class TicTacToeHomeScreen extends StatefulWidget {
  const TicTacToeHomeScreen({Key? key}) : super(key: key);

  @override
  _TicTacToeHomeScreenState createState() => _TicTacToeHomeScreenState();
}

class _TicTacToeHomeScreenState extends State<TicTacToeHomeScreen> {
  int _scoreX = 0;
  int _scoreO = 0;
  final gameController = Get.put(GameController());

  bool _turnOfO = true;
  int _filledBoxes = 0;
  final List<String> _xOrOList = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
      appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          leadingWidth: 100,
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Row(children: [
                SizedBox(
                  width: 20,
                ),
                LineIcon.times(),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Close",
                  style:
                      TextStyle(color: Get.isDarkMode ? whiteColor : darkColor),
                )
              ]))),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildPointsTable(),
            _buildGrid(context),
            IconButton(
                onPressed: () => _clearBoard(), icon: Icon(Icons.refresh)),
            _buildTurn(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsTable() {
    return Expanded(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientWidget(
                          Icon(UniconsLine.multiply, size: 30),
                          gradient: LinearGradient(
                            colors: gameController.gradients[
                                gameController.selectedGradientIndex.value],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                _scoreX.toString() + " - " + _scoreO.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientWidget(
                          Icon(UniconsLine.circle, size: 30),
                          gradient: LinearGradient(
                            colors: gameController.gradients[
                                gameController.selectedGradientIndex.value + 1],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return Expanded(
      flex: 3,
      child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            int i = index ~/ 3; // Dòng
            int j = index % 3; // Cột
            BoxBorder border = Border();
            BorderSide borderStyle = BorderSide(
                width: 1, color: Get.isDarkMode ? whiteColor : darkColor);
            double height = 80;
            double width = 60;

            if (j == 1) {
              border = Border(right: borderStyle, left: borderStyle);
              height = width = 80;
            }
            if (i == 1) {
              border = Border(top: borderStyle, bottom: borderStyle);
            }
            if (i == 1 && j == 1) {
              border = Border(
                top: borderStyle,
                bottom: borderStyle,
                left: borderStyle,
                right: borderStyle,
              );
            }
            return GestureDetector(
              onTap: () {
                _tapped(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: border,
                ),
                child: Center(
                  child: Container(
                    child: _xOrOList[index] == 'x'
                        ? Container(
                            padding: EdgeInsets.only(
                                top: 5, left: 2, right: 2, bottom: 5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                BlurFilterX(
                                  child: GradientWidget(
                                    Icon(UniconsLine.multiply, size: 80),
                                    gradient: LinearGradient(
                                      colors: gameController.gradients[
                                          gameController
                                              .selectedGradientIndex.value],
                                    ),
                                  ),
                                ),
                                GradientWidget(
                                  Icon(UniconsLine.multiply, size: 80),
                                  gradient: LinearGradient(
                                    colors: gameController.gradients[
                                        gameController
                                            .selectedGradientIndex.value],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : (_xOrOList[index] == 'o'
                            ? Container(
                                padding: EdgeInsets.all(5),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    BlurFilterO(
                                      child: GradientWidget(
                                        Icon(UniconsLine.circle, size: 60),
                                        gradient: LinearGradient(
                                          colors: gameController.gradients[
                                              gameController
                                                      .selectedGradientIndex
                                                      .value +
                                                  1],
                                        ),
                                      ),
                                    ),
                                    GradientWidget(
                                      Icon(UniconsLine.circle, size: 60),
                                      gradient: LinearGradient(
                                        colors: gameController.gradients[
                                            gameController.selectedGradientIndex
                                                    .value +
                                                1],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildTurn() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Turn of',
            ),
            !_turnOfO
                ? Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientWidget(
                          Icon(UniconsLine.multiply, size: 30),
                          gradient: LinearGradient(
                            colors: gameController.gradients[
                                gameController.selectedGradientIndex.value],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(5),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientWidget(
                          Icon(UniconsLine.circle, size: 30),
                          gradient: LinearGradient(
                            colors: gameController.gradients[
                                gameController.selectedGradientIndex.value + 1],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        )),
      ),
    );
  }

  void _tapped(int index) {
    if (_xOrOList[index] == '') {
      setState(() {
        _xOrOList[index] = 'x';
        _filledBoxes += 1;
        _turnOfO = true;

        if (!(_filledBoxes >= 9)) {
          int bestMove = -1000;
          int bestMoveIndex = -1;

          for (int i = 0; i < 9; i++) {
            if (_xOrOList[i] == '') {
              _xOrOList[i] = 'o';
              int moveValue = minimax(_xOrOList, false);
              _xOrOList[i] = '';

              if (moveValue > bestMove) {
                bestMove = moveValue;
                bestMoveIndex = i;
              }
            }
          }

          if (bestMoveIndex != -1) {
            _xOrOList[bestMoveIndex] = 'o';
            _filledBoxes += 1;
            _turnOfO = false;
          }
        }
      });
      _checkTheWinner();
      print("index: " + _filledBoxes.toString());
    }
  }

  int minimax(List<String> board, bool isMaximizing) {
    int result = evaluate(board);

    if (result == 10) {
      return result;
    }
    if (result == -10) {
      return result;
    }
    if (!board.contains('')) {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'o';
          int score = minimax(board, false);
          board[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        if (board[i] == '') {
          board[i] = 'x';
          int score = minimax(board, true);
          board[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  int evaluate(List<String> board) {
    final List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final List<int> position in winningPositions) {
      if (board[position[0]] == 'o' &&
          board[position[1]] == 'o' &&
          board[position[2]] == 'o') {
        return 10;
      }
    }

    for (final List<int> position in winningPositions) {
      if (board[position[0]] == 'x' &&
          board[position[1]] == 'x' &&
          board[position[2]] == 'x') {
        return -10;
      }
    }

    return 0;
  }

  void _checkTheWinner() {
    if (_xOrOList[0] == _xOrOList[1] &&
        _xOrOList[0] == _xOrOList[2] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0], context);
      return;
    }

    if (_xOrOList[3] == _xOrOList[4] &&
        _xOrOList[3] == _xOrOList[5] &&
        _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3], context);
      return;
    }

    if (_xOrOList[6] == _xOrOList[7] &&
        _xOrOList[6] == _xOrOList[8] &&
        _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6], context);
      return;
    }

    if (_xOrOList[0] == _xOrOList[3] &&
        _xOrOList[0] == _xOrOList[6] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0], context);
      return;
    }

    if (_xOrOList[1] == _xOrOList[4] &&
        _xOrOList[1] == _xOrOList[7] &&
        _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1], context);
      return;
    }

    if (_xOrOList[2] == _xOrOList[5] &&
        _xOrOList[2] == _xOrOList[8] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2], context);
      return;
    }

    if (_xOrOList[0] == _xOrOList[4] &&
        _xOrOList[0] == _xOrOList[8] &&
        _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0], context);
      return;
    }

    if (_xOrOList[2] == _xOrOList[4] &&
        _xOrOList[2] == _xOrOList[6] &&
        _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2], context);
      return;
    }

    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '', context);
    }
  }

  void _showAlertDialog(String title, String winner, BuildContext context) {
    Get.defaultDialog(
      backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
      barrierDismissible: false,
      title: title,
      titleStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      content: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(251, 109, 169, 0.3)),
              child: Center(
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(251, 109, 169, 1),
                  ),
                  child: Icon(
                    winner == "" ? LineIcons.handshake : LineIcons.trophy,
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(winner == ''
                    ? 'The match ended in a draw'
                    : 'The winner is'),
                Center(
                  child: winner == ""
                      ? null
                      : (winner == "x"
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: 5, left: 5, right: 5, bottom: 5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GradientWidget(
                                    Icon(UniconsLine.multiply, size: 30),
                                    gradient: LinearGradient(
                                      colors: gameController.gradients[
                                          gameController
                                              .selectedGradientIndex.value],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GradientWidget(
                                    Icon(UniconsLine.circle, size: 30),
                                    gradient: LinearGradient(
                                      colors: gameController.gradients[
                                          gameController
                                                  .selectedGradientIndex.value +
                                              1],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                )
              ],
            )
          ],
        ),
      ),
      cancel: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: OutlinedButton(
            onPressed: () {
              _clearBoard();
              Get.back();
            },
            child: const Text("Close")),
      ),
    );
    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _xOrOList[i] = '';
      }
    });

    _filledBoxes = 0;
  }
}
