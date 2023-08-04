import 'dart:async';
import 'package:flutter/material.dart';
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
            // 問題ページへ行くボタン
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
              child: const Text('START'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
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

class QuizListPage extends StatefulWidget {
  const QuizListPage({super.key});

  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  // 変数リスト
  int _quizlistCnt = quizlist.length; // クイズの数
  int _correctCnt = 0; // 何問正解しているか
  int _listIndex = 0; // 今何問目か
  int _selectedBtn = 0; // 選ばれた答え
  int _currentSec = 10; // タイマー用 制限時間

  String _resultText = ""; // 正解 or 不正解

  // 正解 / 不正解のチェック
  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  // 今が最終問題かのチェック
  bool lastCheck(now) {
    if (now == _quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  // タイマー初期化用関数
  @override
  void initState() {
    super.initState();
    countTimer();
  }

  // 時間切れの処理用関数
  void timeOver() async {
    _resultText = "タイムオーバー"; // 結果の文字を「タイムオーバー」に

    // ダイアログ表示
    final rtext = await answerDialog();

    if (rtext != null) {
      // ダイアログが表示されたら
      setState(() {
        _listIndex++; // 問題カウントを+1して次の問題へ
        _currentSec = 10; // タイマーの制限時間をリセット
        _selectedBtn = 0; // 選ばれた答えをリセット
        countTimer(); //タイマー再スタート
      });
    }
  }

  // タイマーを起動する関数
  Timer countTimer() {
    return Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_selectedBtn == 0) {
          // ボタンが押されていない場合
          if (_currentSec == 0) {
            // 時間切れなら
            timer.cancel(); // タイマーをキャンセル
            timeOver(); // タイムオーバー関数を実行
          } else {
            // 時間がまだ残っていれば
            setState(() {
              _currentSec--; // 時間を減らしていく
            });
          }
        } else {
          // ボタンが押された場合
          timer.cancel(); // タイマーをキャンセル
          answerSelect(); // ボタンが押された時の処理を実行
        }
      },
    );
  }

  // 答えが選択された時の処理
  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      _resultText = "正解！";
      _correctCnt++;
    } else {
      _resultText = "ざんねん・・・";
    }

    final rtext = await answerDialog();

    if (rtext != null) {
      setState(() {
        _listIndex++;
        _selectedBtn = 0;
        countTimer();
      });
    }
  }

  // ダイアログを表示
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
                  MaterialPageRoute(
                    builder: (context) {
                      return ResultPage(_quizlistCnt, _correctCnt);
                    },
                  ),
                );
              } else {
                Navigator.pop(context, _resultText);
              }
            },
            child: Text((lastCheck(_listIndex)) ? "結果発表" : "次の問題"),
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
        title: Text('出題'),
        automaticallyImplyLeading: false, // 上部バーの戻る「＜」矢印をなくす
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第${_listIndex + 1}問 / ${_quizlistCnt}問中'),
                  SizedBox(height: 10),
                  Text(quizlist[_listIndex]['question']),
                ],
              ),
            ),
            SizedBox(height: 20),
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () async {
                  if (_selectedBtn != 0) {
                    // 既にボタンが押されていたら、answerSelect関数を実行
                    answerSelect();
                  }
                  _selectedBtn = i;
                },
                child: Text(quizlist[_listIndex]['answer$i']),
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
                color: Colors.pink, // 背景色
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
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatefulWidget {
  ResultPage(this._quizlistCnt, this._correctCnt);
  int _quizlistCnt;
  int _correctCnt;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  // 結果により画像を切り替える関数
  Widget resultImage() {
    // 画像のパスを入れる変数
    var imagePath;

    // 全問正解の時のみ、画像を切り替える処理
    if (widget._correctCnt == widget._quizlistCnt) {
      imagePath = "images/yeah.png";
    } else {
      imagePath = "images/yeah2.png";
    }

    return Image.asset(
      imagePath, // 設定された画像のパス
      width: 300, // 幅300px
      height: 300, // 高さ300px
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('結果発表'),
        automaticallyImplyLeading: false, // 上部バーの戻る「＜」矢印をなくす
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
