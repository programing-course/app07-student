# **クイズアプリを作ろう 11**

## **結果発表ページに飛ばそう QuizListPage.class**

<br><br>

## **実行結果**

<br>

![question](img/10_question1-2.png)

## **演習**

① 表示の枠を作る  
② 結果表示の文字を作る  
③ 最初のページに戻るボタンを作る  

実行結果を見て、自分で考えて書いてみよう  
「縦に３つのwidgetを配置」  

<br>

```dart

//省略

body: Center(
  child: Column(
    children: [
      Text("○問中○問"),
      Image.asset(""),
      ElevatedButton(
        onPressed: () {},
        child: Text("もう一回"), // ボタンのテキスト
      )
    ],
  ),
),

//省略

```
 
#### **【ソースコード】ResultPage**

```dart

import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 65, 105, 121),
        title: Text("結果発表"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Text("○問中○問"),
            Image.asset(""),
            ElevatedButton(
              onPressed: () {},
              child: Text("もう一回"), // ボタンのテキスト
            )
          ],
        ),
      ),
    );
  }
}



```
