# **クイズアプリを作ろう 03**

## **クイズデータを作る question.dart QuestionPage.class**

<br>

## **実行結果**

<br>

![question](img/03_question1-1.png)

## **演習**

①quizlist.dartを作成。問題情報を記載  
出題データは問題・解答選択肢・正解番号がセット  
Map型Listで作成   

<br>

#### **quizlist.dart**

```dart

// ①quizlist.dartを作成。問題情報を記載
//問題・選択肢の内容はコピペOK
//まずは１問目のデータを作ろう、２問目からはコピペOK
List<Map<String, dynamic>> quizlist = [
  {
    "question": "「カルピス」の名前の由来は何でしょう？", //問題文
    "answer1": "1カルシウム（calcium）とサルピス（salpis）", //選択肢１
    "answer2": "2カルボン酸（carboxylic acid）とピッチ（pitch）", //選択肢２
    "answer3": "3カロリー（calorie）とピストル（pistol）", //選択肢３
    "answer4": "4カルテット（quartet）とピアノ（piano）", //選択肢４
    "correct": 1 //回答番号
  },
  {
    "question": "キリンの舌の長さはどれくらいでしょう？",
    "answer1": "25cm",
    "answer2": "45cm",
    "answer3": "65cm",
    "answer4": "85cm",
    "correct": 2
  },
  {
    "question": "ニンジンは元々どの色だった？",
    "answer1": "赤",
    "answer2": "灰",
    "answer3": "緑",
    "answer4": "紫",
    "correct": 4
  },
  {
    "question": "ビール消費量世界1位のチェコでは、1年で1人あたり、ビール瓶何本分を消費するでしょう？",
    "answer1": "50本",
    "answer2": "100本",
    "answer3": "300本",
    "answer4": "600本",
    "correct": 3
  },
  {
    "question": "ペンギンの中で最も早く泳ぐことができるジェンツーペンギンの移動速度は？",
    "answer1": "時速10km",
    "answer2": "時速30km",
    "answer3": "時速60km",
    "answer4": "時速100km",
    "correct": 2
  },
];

// 省略
```
②question.dart上部に、quizlist.dartの読み込み設定を追加  

#### **question.dart**

```dart
// ②question.dart上部に、quizlist.dartの読み込み設定を追加
import 'package:flutter/material.dart';
import 'quizlist.dart'; // これを追加
  
```

③問題文を表示する枠を作成  

#### **question.dart QuestionPage**

```dart
// ③問題文を表示する枠を作成

class _QuestionPageState extends State<QuestionPage> {
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
      ),
    );
  }
}
```