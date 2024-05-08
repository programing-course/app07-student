# **08_プロパティを追加しよう2**

## **グループ２とグループ３の装飾**

Containerプロパティの練習として、グループ２とグループ３の装飾をしてみよう

<br>

## **実行結果** 

![property](img/08_property1-1.png)

<br>

## **演習** 

①幅(サイズ400)をつける（高さはつけない）  
②背景色と線をつける（好きな色でOK）  
③内側の余白(サイズ20)をつける

自由に値を書き換えて表示を確認してみよう！！

<br>

```dart
  //グループ２
  Container(
    width: 400,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 238, 255, 229),
      border: Border.all(color: Colors.brown, width: 2),
    ),
    padding: EdgeInsets.all(20),
  ),
  //グループ３
  Container(
    width: 400,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 229, 254, 255),
      border: Border.all(color: Colors.brown, width: 2),
    ),
    padding: EdgeInsets.all(20),
  ),

```

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
              child:Column(
                children:[
                  Image.asset(
                    "images/cat001.jpg",
                    width: 100,
                    height: 100,
                  ),
                  Row(
                    children:[
                      Text("名前"),
                      Text("トライさん"),
                    ]
                  ),
                  Row(
                    children:[
                      Text("住み"),
                      Text("東京都"),                      
                    ]
                  ),
                  Row(
                    children:[
                      Text("趣味"),
                      Text("ゲーム\n散歩"),                                            
                    ]
                  ),
                  Row(
                    children:[
                      Text("一言"),
                      Text("初めまして\nよろしくお願いします"),                                                                  
                    ]
                  ),
                ]
              )
            ),
            //グループ２
            Container(
              width: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 255, 229),
                border: Border.all(color: Colors.brown, width: 2),
              ),
              padding: EdgeInsets.all(20),
            ),
            //グループ３
            Container(
              width: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 229, 254, 255),
                border: Border.all(color: Colors.brown, width: 2),
              ),
              padding: EdgeInsets.all(20),
            ),
          ],
        ),
      ),
    );
  }
}

```
