# **クイズアプリを作ろう 10**

## **最終問題のときの処理 QuizListPage.class**

<br><br>

## **実行結果**

次の課題（11_quizlist_09_dialog_final）完了後の結果  
この課題はプログラムエラーのまま終了します
<br>

![question](img/10_question1-2.png)

## **演習**

① 最終問題の判定関数を作る

![question](img/10_question1-1.png)

```dart

//省略

class _QuestionPageState extends State<QuestionPage> {

  //①最終問題判定関数
  bool lastCheck() {
    if (listIndex == quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  void answerSelect() async {
    if (quizlist[listIndex]["correct"] == selectedBtn) {
      resultText = "正解！";
      correctCnt++;
    } else {
      resultText = "ざんねん・・・";
    }


//省略

```

② if文の条件に関数呼び出し

```dart

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Text(resultText),
        actions: [
          TextButton(
            onPressed: () {
              //②判定を追加
              if (lastCheck()) {
              } else {
                Navigator.pop(context); //ダイアログを閉じる
              }
            },
            //②判定を追加
            child: Text(lastCheck() ? "結果発表" : "次の問題"),
          ),
        ],
      ),
    );

```
<br>

![question](img/10_question1-3.png)

<br><br>

### **Widgeをif文で制御することはできない**

最終問題のとき　→　Text("結果発表")  
最終問ではないとき　→　Text("次の問題")  
とするとき

```dart
if(lastCheck()){
  Text("結果発表"), //← Widgetなのでif文が使えれない 
}else{
  Text("次の問題"), //← Widgetなのでif文が使えれない
}
```

この書き方はNG

<br>

### **三項演算子を使って制御する**

![question](img/10_question1-5.png)


<br><br>


③ 最終問題だったら飛び先とボタンのテキストを変更  
飛び先のclassがリンクされていないので、この時点ではエラーになる

```dart

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        content: Text(resultText),
        actions: [
          TextButton(
            onPressed: () {
              if (lastCheck()) {
                //③次のページへ遷移
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      //result.dartのPesultPage.classに飛ぶ
                      return ResultPage();
                    },
                  ),
                );
              } else {
                Navigator.pop(context); //ダイアログを閉じる
              }
            },
            //②判定を追加
            child: Text(lastCheck() ? "結果発表" : "次の問題"),
          ),
        ],
      ),
    );

```

<br>

![question](img/10_question1-4.png)

<br>

④ result.dartをインポート

```dart

import 'package:flutter/material.dart';
import 'quizlist.dart';
import 'result.dart'; //ここ追加

```

<br>


#### **【ソースコード】**

```dart

import 'package:flutter/material.dart';
import 'quizlist.dart';
import 'result.dart';

int listIndex = 0;
int quizlistCnt = quizlist.length;
int selectedBtn = 0;
String resultText = "";
int correctCnt = 0;

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

  bool lastCheck() {
    if (listIndex == quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  void answerSelect() async {
    if (quizlist[listIndex]["correct"] == selectedBtn) {
      resultText = "正解！";
      correctCnt++;
    } else {
      resultText = "ざんねん・・・";
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
    });
  }

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
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () {
                  selectedBtn = i;
                  answerSelect();
                },
                child: Text(quizlist[listIndex]["answer$i"]),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  fixedSize: Size(300, 50),
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
