# **クイズアプリを作ろう 06**

## **選択肢ボタンの情報を管理しよう　QuizListPage.class**

<br>

## **実行結果**

<br>
画面変化なし
<!-- 
![question](img/06_question1-1.png) -->

## **演習**

![question](img/06_question1-2.png)

① 変数「selectedBtn」を作成し、初期値に０を代入  

```dart

import 'package:flutter/material.dart';
import 'quizlist.dart';


int listIndex = 0;
int quizlistCnt = quizlist.length;
//①　選択肢ボタンの番号
int selectedBtn = 0;

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

```

② 選択肢ボタンが押されたら、ボタンの番号をselectedBtnに代入する  

```dart

ElevatedButton(
  onPressed: () {
    //②　何番目のボタンが押されたか代入
    selectedBtn = 1;
  },
  child: Text(quizlist[listIndex]["answer1"]),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    fixedSize: Size(300, 50),
  ),
),

```

<br>

#### **【ソースコード】**

```dart

// 省略

import 'package:flutter/material.dart';
import 'quizlist.dart';


int listIndex = 0;
int quizlistCnt = quizlist.length;
//①　選択肢ボタンの番号
int selectedBtn = 0;

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 65, 105, 121),
        title: Text("問題"),
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
                  Text("第${listIndex + 1}問 / ${quizlistCnt}問中"),
                  SizedBox(height: 10),
                  Text(quizlist[listIndex]["question"]),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //②　何番目のボタンが押されたか代入
                selectedBtn = 1;
              },
              child: Text(quizlist[listIndex]["answer1"]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                fixedSize: Size(300, 50),
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
