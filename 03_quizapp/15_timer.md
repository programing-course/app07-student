# **クイズアプリを作ろう タイマー追加**

## **カウントダウンタイマーを作る**

![timer](img/15_timer1-1.png)

<br>

- [ ] ① カウントダウン表示用Containerを作る  

```dart

Container(
  width: 50,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.pink,
  ),
  child: Center(
    child: Text(
      "10",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  ),
)

```

- [ ] ②一番上に「import 'dart:async';」を追加

```dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'quizlist.dart';
import 'result.dart';

```

- [ ] ③変数「_currentSec」を作り、10を代入（10秒のタイマー）
- [ ] ④タイマー用の関数作成
- [ ] ⑤タイムオーバー処理
- [ ] ⑥タイマーリセット

```dart

class _QuestionPageState extends State<QuestionPage> {
  //ローカル変数
  int _currentSec = 10; //③タイマー
  bool _timeOver = false; //③タイムオーバー判定

  @override
  void initState() {
    super.initState();

    listIndex = 0;
    quizlistCnt = quizlist.length;
    selectedBtn = 0;
    resultText = "";
    correctCnt = 0;

    //④タイマースタート
    countTimer();
  }

  bool lastCheck() {
    if (listIndex == quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  Timer countTimer() {
    return Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      //⑤回答有無
      if (selectedBtn == 0) {
        //⑤タイムオーバー判定
        if (_currentSec == 0) {
          timer.cancel();
          _timeOver = true;
          answerSelect();
        } else {
          if (this.mounted) {
            setState(() {
              _currentSec--;
            });
          }
        }
      } else {
        timer.cancel();
        answerSelect();
      }
    });
  }

  void answerSelect() async {
    //⑤タイムオーバー判定追加
    if (_timeOver) {
      resultText = "タイムオーバー";
    } else {
      if (quizlist[listIndex]["correct"] == selectedBtn) {
        resultText = "正解！";
        correctCnt++;
      } else {
        resultText = "ざんねん・・・";
      }
    }

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Text(resultText),
        actions: [
          TextButton(
            onPressed: () {
              if (lastCheck()) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      //result.dartのPesultPage.classに飛ぶ
                      return ResultPage();
                    },
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(lastCheck() ? "結果発表" : "次の問題"),
          ),
        ],
      ),
    );

    setState(() {
      listIndex++;
      selectedBtn = 0;
      _currentSec = 10; //⑥タイマーリセット
      _timeOver = false; //⑥ゲームオーバー判定リセット
      countTimer(); //⑥タイマー再起動
    });
  }

  @override
  Widget build(BuildContext context) {

  //省略

```

- [ ] ⑦ボタンが押された時の処理　answerSelectをコメントアウト

```dart

//省略

for (int i = 1; i <= 4; i++) ...{
  ElevatedButton(
    onPressed: () {
      //answerSelect();
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

//省略

```

- [ ] ⑧タイマーのTextを変数に変更

```dart

Container(
  width: 50,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.pink,
  ),
  child: Center(
    child: Text(
      //変数に変更
      "${_currentSec}",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  ),
)
```
