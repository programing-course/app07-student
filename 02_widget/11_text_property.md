# **11_テキストの装飾**

![image](img/11_textproperty1-1.png) 

<br><br>

## **実行結果**

![image](img/11_textproperty1-2.png) 

<br><br>


## **演習**

①Textにstyle: TextStyleを追加

```dart
  Text(
    "トライさん",
    style: TextStyle(
      fontSize: 20,
      color: Colors.cyan[300],
      fontWeight: FontWeight.bold,
    ),
  ),
```

<br><br>

②自由にText部分を装飾しよう  

下のコード参考に追加してみよう！  

```dart
    //文字の大きさ
    fontSize: 20,
    //文字の色
    color: Colors.cyan[300],
    color: Colors.green,
    //文字の太さ
    fontWeight: FontWeight.bold,
    //文字をイタリック
    fontStyle: FontStyle.italic,
    //アンダーラインを引く
    decoration: TextDecoration.underline,
    decorationColor: Colors.red, // 下線の色
    decorationStyle: TextDecorationStyle.dashed, // 下線のスタイル
    // 文字間のスペース
    letterSpacing: 2.0,
    // 単語間のスペース
    wordSpacing: 5.0, 
    shadows: [
      Shadow(
        // テキストの影
        blurRadius: 10.0,
        color: Colors.black45,
        offset: Offset(5, 5),
      ),
    ],
```

<br><br>

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
              child: ListView(
                children: [
                  Image.asset(
                    "images/cat001.jpg",
                    width: 100,
                    height: 100,
                  ),
                  Row(children: [
                    Text("名前"),
                    SizedBox(width: 20),
                    //①カンマをつけて「style」を追加
                    Text("トライさん",
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
                ]
              )
            ),
            SizedBox(height: 10),
            //グループ２
            Container(
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 255, 229),
                border: Border.all(color: Colors.brown, width: 2),
              ),
            ),
            SizedBox(height: 10),
            //グループ３
            Container(
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 254, 255),
                border: Border.all(color: Colors.brown, width: 2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




```
