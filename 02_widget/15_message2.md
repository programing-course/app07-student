# **15_メッセージ送信したときの処理**

## **メッセージを表示しよう**

![message](img/15_message1-1.png)

<br>

## **実行結果**

![message](img/15_message1-2.png) 

<br><br>

## **演習**

①変数textを作り、初期値を空白にする  

```dart
class _MyHomePageState extends State<MyHomePage> {
  var good = 0;
  // ①変数textを追加
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        <省略>
      ),
    );
  }
}

```

②onChangedの中に入力した文字列をtextに代入する処理を追加  
③onPressedの中に送信アイコンが押されたら再描画  
④textを画面に表示する

```dart
  child: Column(
    children: [
      Row(
        children: [
          Container(
            width: 230,
            child: TextField(
              onChanged: (String value) {
                //②入力データをtextに代入
                text = value;
              },
              maxLines: 2,
              minLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: Colors.blue,
            ),
            onPressed: () {
              //③送信ボタンがおされたら再描画
              setState(() {},);
            },
          ),
        ],
      ),
      SizedBox(height: 10),
      //④変数textを表示
      Text("$text"),
    ],
  ),
```

<br>

### **【ソースコード】**

```dart
// flutterパッケージを読み込み
import 'package:flutter/material.dart';

// アプリを起動
void main() => runApp(MyApp());

// アプリ全体の設定
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: '自己紹介'),
    );
  }
}

// MyHomePage の情報を入れるclass
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// MyHomePage の中身を入れるclass
class _MyHomePageState extends State<MyHomePage> {
  var good = 0;
  // ①変数textを追加
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //グループ１
            Container(
                width: 400,
                height: 350,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 229, 229),
                  border: Border.all(color: Colors.brown, width: 2),
                ),
                padding: EdgeInsets.all(20),
                child: ListView(children: [
                  Image.asset(
                    "images/cat001.jpg",
                    width: 100,
                    height: 100,
                  ),
                  Row(children: [
                    Text("名前"),
                    SizedBox(width: 20),
                    Text(
                      "トライさん",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.cyan[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    Text("住み"),
                    SizedBox(width: 20),
                    Text("東京都"),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    Text("趣味"),
                    SizedBox(width: 20),
                    Text("ゲーム\n散歩"),
                  ]),
                  SizedBox(height: 20),
                  Row(children: [
                    Text("一言"),
                    SizedBox(width: 20),
                    Flexible(
                      child: Text(
                          "初めまして\nよろしくお願いします\nプログラミングの楽しいところは自分がイメージしたものを形にすることができる!思い通りに動いた時の達成感を感じでほしいです。"),
                    ),
                  ]),
                ])),
            SizedBox(height: 10),
            //グループ２
            Container(
                width: 400,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 255, 229),
                  border: Border.all(color: Colors.brown, width: 2),
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          good++;
                        });
                      },
                      child: Text('いいね！'),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "${good}",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('もっと見る'),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            //グループ３
            Container(
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 254, 255),
                border: Border.all(color: Colors.brown, width: 2),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 230,
                        child: TextField(
                          controller: messageTextController,
                          onChanged: (String value) {
                            //②入力データをtextに代入
                            text = value;
                          },
                          maxLines: 2,
                          minLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          //③送信ボタンがおされたら再描画
                          setState(() {},
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  //④変数textを表示
                  Text("$text"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




```
