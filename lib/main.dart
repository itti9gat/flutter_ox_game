import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'O X Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double RADIUS_CORNER = 15.0;
  static const int NONE = 0;
  static const int VALUE_O = 1;
  static const int VALUE_X = 2;

  int currentTurn = VALUE_O;

  List<List<int>> boxValue = [
    [NONE, NONE, NONE],
    [NONE, NONE, NONE],
    [NONE, NONE, NONE],
  ];

  bool isGameEndedByWin() {
    // check vertical.
    for (int col = 0; col < 3; col++) {
      if (boxValue[0][col] != NONE &&
          boxValue[0][col] == boxValue[1][col] &&
          boxValue[1][col] == boxValue[2][col]) {
        return true;
      }
    }

    // check horizontal.
    for (int row = 0; row < 3; row++) {
      if (boxValue[row][0] != NONE &&
          boxValue[row][0] == boxValue[row][1] &&
          boxValue[row][1] == boxValue[row][2]) {
        return true;
      }
    }

    // check cross left to right.
    if (boxValue[0][0] != NONE &&
        boxValue[0][0] == boxValue[1][1] &&
        boxValue[1][1] == boxValue[2][2]) {
      return true;
    }

    // check cross right to left.
    if (boxValue[0][2] != NONE &&
        boxValue[0][2] == boxValue[1][1] &&
        boxValue[1][1] == boxValue[2][0]) {
      return true;
    }

    return false;
  }

  bool isGameEndedByDraw() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if(boxValue[row][col] == NONE){
          return false;
        }
      }
    }
    return true;
  }

  playAgain() {
    setState(() {
      currentTurn = VALUE_O;
      boxValue = [
        [NONE, NONE, NONE],
        [NONE, NONE, NONE],
        [NONE, NONE, NONE],
      ];
    });
  }

  void showEndGameDialog(int status) {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("The winner is",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black45,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0,),
          Icon(getIconImg(status), size: 60, color: getColorStatus(status)),
          SizedBox(height: 30.0,),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            color: Colors.yellow[800],
            child: Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              playAgain();
              Navigator.of(context).pop();
            },
          )
        ]));
      },
    );
  }

  void showDuelGameDialog() {
    // flutter defined function
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Draw",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 30.0,),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            color: Colors.yellow[800],
            child: Text("Play again",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              playAgain();
              Navigator.of(context).pop();
            },
          )
        ]));
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text("Player",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 40.0,
                            color: getTurnColor(VALUE_O, currentTurn),
                          )),
                    ),
                    SizedBox(width: 8.0),
                    Icon(getIconImg(VALUE_O),
                        size: 40, color: getTurnColor(VALUE_O, currentTurn)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text("Player",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 40.0,
                              color: getTurnColor(VALUE_X, currentTurn))),
                    ),
                    Icon(getIconImg(VALUE_X),
                        size: 50, color: getTurnColor(VALUE_X, currentTurn)),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(RADIUS_CORNER),
                      topRight: Radius.circular(RADIUS_CORNER),
                      bottomLeft: Radius.circular(RADIUS_CORNER),
                      bottomRight: Radius.circular(RADIUS_CORNER))),
              child: Container(
                color: Colors.brown,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildChannel(1, 0, 0),
                        buildChannel(2, 0, 1),
                        buildChannel(3, 0, 2),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildChannel(1, 1, 0),
                        buildChannel(2, 1, 1),
                        buildChannel(3, 1, 2),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildChannel(1, 2, 0),
                        buildChannel(2, 2, 1),
                        buildChannel(3, 2, 2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  void switchPlayer() {
    if (currentTurn == VALUE_X) {
      currentTurn = VALUE_O;
    } else if (currentTurn == VALUE_O) {
      currentTurn = VALUE_X;
    }
  }

  Widget buildChannel(int idx, int row, int col) {
    return InkWell(
      onTap: () {
        if (boxValue[row][col] == NONE) {
          setState(() {
            boxValue[row][col] = currentTurn;

            if (isGameEndedByWin()) {
              showEndGameDialog(currentTurn);
            } else {
              if (isGameEndedByDraw()) {
                showDuelGameDialog();
              } else {
                switchPlayer();
              }
            }
          });
        }
      },
      child: Container(
        width: 115.0,
        height: 115.0,
        margin: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: getColorStatus(boxValue[row][col]),
          border: Border(
            left: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
            bottom: BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
        ),
        child: getIconData(boxValue[row][col]),
      ),
    );
  }

  Color getColorStatus(int status) {
    if (status == 1) {
      return Color.fromRGBO(127, 208, 228, 1.0);
    } else if (status == 2) {
      return Color.fromRGBO(232, 138, 75, 1.0);
    }

    return Colors.white;
  }

  Icon getIconData(int status) {
    if (status == 1) {
      return Icon(getIconImg(status),
          size: 80, color: Color.fromRGBO(60, 135, 145, 1.0));
    } else if (status == 2) {
      return Icon(getIconImg(status),
          size: 85, color: Color.fromRGBO(140, 90, 40, 1.0));
    }

    return null;
  }

  IconData getIconImg(int status) {
    if (status == 1) {
      return Icons.panorama_fish_eye;
    } else if (status == 2) {
      return Icons.clear;
    }

    return null;
  }

  Color getTurnColor(int base, int status) {
    if (base == 1) {
      if (status == 1) {
        return Color.fromRGBO(60, 135, 145, 1.0);
      } else {
        return Color.fromRGBO(230, 230, 230, 1.0);
      }
    }

    if (base == 2) {
      if (status == 1) {
        return Color.fromRGBO(230, 230, 230, 1.0);
      } else {
        return Color.fromRGBO(140, 90, 40, 1.0);
      }
    }

    return null;
  }
}
