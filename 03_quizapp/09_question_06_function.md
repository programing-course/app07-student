# **クイズアプリを作ろう 08**

## **回答後の処理をつくろう　関数にまとめる QuestionPage.class**

<br>

## **実行結果**

<br>

![question](img/08_question1-1.png)

## **演習**

![question](img/08_question1-2.png)


①回答後の処理を関数にまとめる

```dart
class _QuestionPageState extends State<QuestionPage> {
  int _listIndex = 0;
  int _selectedBtn = 0;

  //①関数を作成
  void answerSelect() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      <省略>
      for (int i = 1; i <= 4; i++) ...{
        ElevatedButton(
          onPressed: () {
            _selectedBtn = i;
            //②答えが選択された時の処理を呼び出す
            answerSelect();
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
      <省略>
    );
  }
}

```

②正解 / 不正解のチェック関数を作る

- 「now」・・・現在の問題
- 「selected」・・・選んだ答え
- 戻り値　正解＝true 不正解＝false

③正解 / 不正解のチェック関数を呼び出す


```dart

class _QuestionPageState extends State<QuestionPage> {
  int _listIndex = 0;
  int _selectedBtn = 0;

  // ②正解 / 不正解のチェック
  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  // 答えが選択された時の処理
  void answerSelect() async {
    //③if文の中で関数呼び出し、戻り値で判定
    if (correctCheck(_listIndex, _selectedBtn) == true) { 
      // 正解
    } else { 
      // 不正解
    }
  }

  @override
  Widget build(BuildContext context) {
    <省略>
  }
}
```
④正解の場合「正解」不正解の場合「ざんねん・・・」  
⑤正解数をカウントする  

```dart

class _QuestionPageState extends State<QuestionPage> {
  int _listIndex = 0;
  int _selectedBtn = 0;
  //④ 正解 or 不正解
  String _resultText = "";
  //⑤ 正解数
  int _correctCnt = 0;

  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  // 答えが選択された時の処理
  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) { 
      //④
      _resultText = "正解！";
      //⑤
      _correctCnt++;
    } else { 
      //④
      _resultText = "ざんねん・・・";
    }
  }

  @override
  Widget build(BuildContext context) {
    <省略>
  }
}
```

① 変数を3つ作成  
- _quizlistCnt：全クイズの数
- _correctCnt：正解数
- _resultText：正解or不正解の文字用
  
② 関数を3つ作成  
- correctCheck：正解 / 不正解のチェック
- lastCheck：今が最終問題かのチェック
- answerSelect：答えが選択された時の処理

③ 変数と関数を設定
- _quizlistCntをテキスト内に
- answerSelectをonPressed内に


<br>

#### **【ソースコード】**

```dart

import 'package:flutter/material.dart';
import 'quizlist.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _listIndex = 0;
  int _selectedBtn = 0;
  String _resultText = "";  //④ 正解 or 不正解
  int _correctCnt = 0;　//⑤ 正解数

  // ②正解 / 不正解のチェック
  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  //① 答えが選択された時の処理
  void answerSelect() async {
    //③if文の中で関数呼び出し、戻り値で判定
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      _resultText = "正解！";//④
      _correctCnt++;//⑤
    } else {
      _resultText = "ざんねん・・・";//④
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('問題'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第${_listIndex + 1}問 / □問中'),
                  SizedBox(height: 10),
                  Text(quizlist[_listIndex]["question"]),
                ],
              ),
            ),
            SizedBox(height: 20),
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () {
                  _selectedBtn = i;
                  //① 関数呼び出し
                  answerSelect();
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
          ],
        ),
      ),
    );
  }
}


```
