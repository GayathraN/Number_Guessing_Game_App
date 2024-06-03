import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flame_audio/flame_audio.dart';

class GuessingGameScreen extends StatefulWidget {
  final bool singlePlayer;

  GuessingGameScreen({required this.singlePlayer});

  @override
  _GuessingGameScreenState createState() => _GuessingGameScreenState();
}

class _GuessingGameScreenState extends State<GuessingGameScreen> {
  final TextEditingController _controller = TextEditingController();
  late Game _game;
  String _resultMessage = '';
  bool _gameOver = false;
  int _currentPlayer = 1;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('bgMusic.mp3', volume: 0.2);

    _game = Game();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 6));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _submitGuess() {
    int? guess = int.tryParse(_controller.text);
    String message;

    if (guess == null) {
      message = 'Please enter a valid number';
    } else if (guess == _game.numberToGuess) {
      message = 'Correct! Well Done, Player $_currentPlayer!';
      setState(() {
        _gameOver = true;
        _game.calculateScore(_currentPlayer);
      });
      _confettiController.play();
      FlameAudio.bgm.stop();
      FlameAudio.play('win.mp3');
      _showGameOverDialog(message, true);
    } else {
      int difference = (guess - _game.numberToGuess).abs();
      if (guess < _game.numberToGuess) {
        if (difference <= 10) {
          message = 'Low!';
        } else {
          message = 'Too low!';
        }
      } else {
        if (difference <= 10) {
          message = 'High!';
        } else {
          message = 'Too high!';
        }
      }

      setState(() {
        if (widget.singlePlayer) {
          _game.singlePlayerAttempts++;
          if (_game.singlePlayerAttempts >= Game.totalAttempts) {
            _gameOver = true;
            message = 'Game Over! The number was ${_game.numberToGuess}';
            _game.calculateScore(_currentPlayer);
            FlameAudio.bgm.stop();
            FlameAudio.play('gameOver.mp3');
            _showGameOverDialog(message, false);
          }
        } else {
          if (_currentPlayer == 1) {
            _game.player1Attempts++;
            if (_game.player1Attempts >= Game.totalAttempts) {}
          } else {
            _game.player2Attempts++;
            if (_game.player2Attempts >= Game.totalAttempts) {
              _gameOver = true;
              message = 'Game Over! The number was ${_game.numberToGuess}';
              _game.calculateScore(_currentPlayer);
              FlameAudio.bgm.stop();
              FlameAudio.play('gameOver.mp3');
              _showGameOverDialog(message, false);
            }
          }
          _currentPlayer = _currentPlayer == 1 ? 2 : 1; // Switch players
        }
        _resultMessage = message;
        _controller.clear(); // Clear the input text box
      });
    }
  }

  void _playAgain() {
    setState(() {
      _controller.clear();
      _resultMessage = '';
      _gameOver = false;
      _game = Game(); // Create a new game with a new random number
      _currentPlayer = 1; // Reset to player 1
    });
    Navigator.of(context).pop();
    FlameAudio.bgm.play('bgMusic.mp3', volume: 0.2);
  }

  void _showGameOverDialog(String message, bool isWinner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              isWinner ? 'CONGRATULATIONS!' : 'YOU LOST!',
              style: TextStyle(
                color: Color.fromARGB(255, 219, 121, 29),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 20,
                  blastDirectionality: BlastDirectionality.explosive,
                  gravity: 0.2,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple,
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(message,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    )),
              ),
              SizedBox(height: 20),
              if (widget.singlePlayer)
                Text('Your Score: ${_game.singlePlayerScore}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ))
              else ...[
                Text('Player 1 Score: ${_game.player1Score}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
                Text('Player 2 Score: ${_game.player2Score}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _playAgain,
                child: Text('Play Again', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttemptCounter(String player, int attemptsLeft) {
    return Column(
      children: [
        if (widget.singlePlayer) ...[
          Text(
            'Attempts left: ',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            '$attemptsLeft',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ] else ...[
          Text(player),
          Text(
            'Attempts left: ',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            '$attemptsLeft',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 113, 136),
        title: Text(
          widget.singlePlayer ? 'Singleplayer Game' : 'Multiplayer Game',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_gameOver)
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      color: Colors.grey,
                    ),
                  )
                else if (_gameOver)
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        '${_game.numberToGuess}',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Text(
                  'Guess the number [1 - 100]',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your guess',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _submitGuess,
                  child: Text(
                    'Submit Guess',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 55, 113, 136),
                    onPrimary: Colors.white, // text color
                  ),
                ),
                if (_resultMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      _resultMessage,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                if (!widget.singlePlayer)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Player $_currentPlayer\'s turn',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (widget.singlePlayer)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildAttemptCounter(
                  '',
                  Game.totalAttempts - _game.singlePlayerAttempts,
                ),
              ),
            )
          else ...[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildAttemptCounter(
                  'Player 1',
                  Game.totalAttempts - _game.player1Attempts,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildAttemptCounter(
                  'Player 2',
                  Game.totalAttempts - _game.player2Attempts,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Score generation

class Game {
  static const int totalAttempts = 10;
  final int numberToGuess;
  int singlePlayerAttempts = 0;
  int player1Attempts = 0;
  int player2Attempts = 0;
  int singlePlayerScore = 0;
  int player1Score = 0;
  int player2Score = 0;

  Game() : numberToGuess = Random().nextInt(100) + 1;

  void calculateScore(int player) {
    if (player == 1) {
      player1Score = max(0, (totalAttempts - player1Attempts) * 10);
    } else if (player == 2) {
      player2Score = max(0, (totalAttempts - player2Attempts) * 10);
    }
    if (player == 1 && singlePlayerAttempts > 0) {
      singlePlayerScore = (totalAttempts - singlePlayerAttempts) * 10;
    }
  }
}
