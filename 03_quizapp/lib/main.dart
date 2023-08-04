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

// QuizListPage
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

  String _resultText = ""; // 正解 or 不正解

  // 正解したかのチェック
  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  // 最終問題かのチェック
  bool lastCheck(now) {
    if (now == _quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  // 入力された答えをチェックする用の関数
  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      // 合っていたら
      _resultText = "正解！";
      _correctCnt++;
    } else {
      // 合っていなかったら
      _resultText = "ざんねん・・・";
    }

    // ポップアップを表示するための_answerDialog関数を実行
    final rtext = await answerDialog();

    // ポップアップが表示されたら
    if (rtext != null) {
      setState(() {
        _listIndex++; // 次の問題へ
        _selectedBtn = 0; // 選ばれたボタンの情報をリセット
      });
    }
  }

  // ポップアップ表示の関数
  dynamic answerDialog() {
    // showDialogで作ったものの結果を返したいので、変数に入れている？
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
    return rtn; // 結果をお返し
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
            // ボタンを4つ生成
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () async {
                  _selectedBtn = i;
                  answerSelect();
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
  // 結果画像表示用関数
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
            Text(
              "${widget._quizlistCnt}問中 ${widget._correctCnt}問正解",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
