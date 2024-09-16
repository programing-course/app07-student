# **quizListにカラーコードを追加しよう**

現在のquizlist.dartに単純にラーコードを追加してもカラーコードとして認識されません。
呼び出したときに色ではなく文字列として表示されてしまいます。

<br>

## **現在のquizlist.dartに新しくMap型Listを作る**

今あるquizlistとは別のMap型Listを追加します

<br>

#### **quizlist.dart**

```dart

import 'package:flutter/material.dart';

List<Map<String, dynamic>> quizlist = [
  {
   //省略
  },
];

//dynamicではなくColorを指定する新しいMap型Listの作成
List<Map<String,Color>> Colorcode = [
  {
    "black": Color(0xff000000),　//黒のカラーコードを"black"という変数で管理している
  },
];

```

<br>

## **カラーコードを変換**

一般的にカラーコードを調べると#から始まる7桁の英数字であらわされている。  
例えば  
黒のカラーコードを調べると  
#000000  
と出てくるが、このままでは使うことができない。  
そこで使えるように少し変更をしてあげる必要がある。  
#を0xffに変える  
#000000->0xff000000  
と変えてあげよう  
他の色でも同様のことを行えばよい  

<br>

## **コード内での使い方**

問題文を表示したときと同様にMap型Listの名前を用いて使うことができる


### **question.dart**

試しに選択しの背景をさっき作ったMap型Listを用いて変更してみよう

```dart

//省略

class _QuestionPageState extends State<QuestionPage> {


  void answerSelect() {
    if (quizlist[listIndex]["correct"] == selectedBtn) {
      resultText = "正解！";
      correctCnt++;
    }else{
      resultText = "ざんねん・・・";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
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
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () {
                  selectedBtn = i;
                  answerSelect();
                },
                child: Text(quizlist[listIndex]["answer$i"]),
                style: ElevatedButton.styleFrom(
                  //色を直接指定しているのではなくListから黒のカラーコードを持ってきている部分
                  backgroundColor: Colorcode[0]["black"], 
                  //色を直接指定している部分 
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

<br>

選択肢の背景が変わっていればOK

<br>