import 'package:flutter/material.dart';
import 'dart:async';
import 'quizlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartPage(),
    );
  }
}

// StartPage
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('クイズアプリ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/quiz.png",
              width: 200,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return QuizListPage();
                    },
                  ),
                );
              },
              child: Text('START'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 237, 194, 0),
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// QuizListPage
class QuizListPage extends StatefulWidget {
  const QuizListPage({super.key});

  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  // 変数リスト
  int _quizlistCnt = quizlist.length;
  int _correctCnt = 0;
  int _listIndex = 0;
  int _selectedBtn = 0;
  int _currentSec = 10;

  String _resultText = "";
  String _hint = ""; // ★ヒント用の変数追加

  // 関数
  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  bool lastCheck(now) {
    if (now == _quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    countTimer();
  }

  // 同期処理 - >　読み込みながら表示   非同期処理 -> 全部読み込んでから、1度だけ表示

  void timeOver() async {
    _resultText = "タイムオーバー";

    final rtext = await answerDialog();

    if (rtext != null) {
      setState(() {
        _listIndex++;
        _currentSec = 10;
        _selectedBtn = 0;
        _hint = ""; // ★ヒントの文字を初期化
        countTimer();
      });
    }
  }

  Timer countTimer() {
    return Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_selectedBtn == 0) {
        if (_currentSec == 0) {
          timer.cancel();
          timeOver();
        } else {
          setState(() {
            _currentSec--;
          });
        }
      } else {
        timer.cancel();
        answerSelect();
      }
    });
  }

  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      _resultText = "正解!";
      _correctCnt++;
    } else {
      _resultText = "ざんねん…";
    }

    final rtext = await answerDialog();

    if (rtext != null) {
      setState(() {
        _listIndex++;
        _selectedBtn = 0;
        _currentSec = 10;
        _hint = "";
        countTimer();
      });
    }
  }

  dynamic answerDialog() {
    var rtn = showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(_resultText),
        actions: [
          TextButton(
            onPressed: () {
              if (lastCheck(_listIndex) == true) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ResultPage(_quizlistCnt, _correctCnt);
                  }),
                );
              } else {
                Navigator.pop(context, _resultText);
              }
            },
            child: Text(lastCheck(_listIndex) ? "結果発表" : "次の問題"),
          ),
        ],
      ),
    );
    return rtn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('問題'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 200, // ！！！！！！高さ変えてあげる
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第${_listIndex + 1}問 / ${_quizlistCnt}問中'),
                  SizedBox(height: 10),

                  // ★今までの正解数
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "●" * _correctCnt,
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(" / "),
                      Text(
                        "×" * (_listIndex - _correctCnt),
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  // ★今までの正解数ここまで
                  //
                  SizedBox(height: 10),
                  Text(quizlist[_listIndex]["question"]),
                  // ★ヒントここから
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _hint = quizlist[_listIndex]["hint"];
                    },
                    child: Text("ヒント"),
                  ),
                  Text(_hint),
                  // ★ヒントここまで
                ],
              ),
            ),
            SizedBox(height: 20),
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () async {
                  if (_selectedBtn != 0) {
                    answerSelect();
                  }
                  _selectedBtn = i;
                },
                child: Text(quizlist[_listIndex]["answer$i"]),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  fixedSize: Size(200, 50),
                ),
              ),
              SizedBox(height: 20),
            },
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.pink,
              ),
              child: Center(
                child: Text(
                  _currentSec.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ResultPage
class ResultPage extends StatefulWidget {
  ResultPage(this._quizlistCnt, this._correctCnt);
  int _quizlistCnt;
  int _correctCnt;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Widget resultImage() {
    var imagePath;

    if (widget._correctCnt == widget._quizlistCnt) {
      imagePath = "images/yeah.png";
    } else {
      imagePath = "images/yeah2.png";
    }

    return Image.asset(
      imagePath,
      width: 300,
      height: 300,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('結果発表'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ★正解発表
            Container(
              width: 400,
              height: 200,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "問題",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "正解",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  for (int i = 0; i <= 4; i++) ...{
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child:
                                Text("${i + 1} / ${quizlist[i]["question"]}")),
                        SizedBox(width: 30),
                        Flexible(
                            child: Text(
                          quizlist[i]["answer${quizlist[i]["correct"]}"],
                          style: TextStyle(color: Colors.blue),
                          textAlign: TextAlign.right,
                        )),
                      ],
                    ),
                    SizedBox(height: 20),
                  },
                ],
              ),
            ),
            // ★正解発表ここまで
            //
            Text(
              "${widget._quizlistCnt}問中 ${widget._correctCnt}問正解",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: resultImage(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("もう一回"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
