# **クイズアプリを作ろう 03**

## **クイズデータを作る QuizListPage.class**

<br>

①quizlist.dartを作成。問題情報を記載  
②main.dart上部に、quizlist.dartの読み込み設定を追加  
③問題文を表示する枠を作成  

<br>

#### **【ソースコード】quizlist.dart**

```dart

// ①quizlist.dartを作成。問題情報を記載
  List<Map<String, dynamic>> quizlist = [
    {
      "question": "日本一高い山は",   //問題文
      "answer1": "富士山",          //選択肢１
      "answer2": "北岳",            //選択肢２
      "answer3": "奥穂高岳",        //選択肢３
      "answer4": "間ノ岳",          //選択肢４
      "correct": 1                 //回答番号
    },
    {
      "question": "問題２",
      "answer1": "答え１",
      "answer2": "答え２",
      "answer3": "答え３",
      "answer4": "答え４",
      "correct": 4
    },
    {
      "question": "問題３",
      "answer1": "答え１",
      "answer2": "答え２",
      "answer3": "答え３",
      "answer4": "答え４",
      "correct": 2
    },
    {
      "question": "問題４",
      "answer1": "答え１",
      "answer2": "答え２",
      "answer3": "答え３",
      "answer4": "答え４",
      "correct": 3
    },
    {
      "question": "問題５",
      "answer1": "答え１",
      "answer2": "答え２",
      "answer3": "答え３",
      "answer4": "答え４",
      "correct": 2
    },
  ];
// 省略
```
  

#### **【ソースコード】main.dart**

```dart
// ②main.dart上部に、quizlist.dartの読み込み設定を追加
import 'package:flutter/material.dart';
import 'quizlist.dart'; // これを追加
  
```

  

#### **【ソースコード】main.dart QuizListPage**

```dart
// ③問題文を表示する枠を作成

class _QuizListPageState extends State<QuizListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('問題'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        // ★Centerの中に追加
        // コピペOK ↓ここから
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第○問 / □問中'),
                  SizedBox(height: 10),
                  Text('問題文'),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {},
              child: Text('選択肢1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
        // ↑ここまで
      ),
    );
  }
}
```