# **自己紹介アプリを作ろう 10**

## **いいねボタンを作ろう！その1**

<br>

①ElevatedButtonを追加  
②カウントテキストを追加

<br>

### **【ソースコード】**

- // ★ の箇所を修正しよう

```dart
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.brown, width: 2),
              ),
              child: ListView(
                children: [
                  Image.asset(
                    "images/cat.png",
                    width: 100,
                    height: 100,
                  ),
                  Text('名前：〇〇'),
                  Text('住み：〇〇'),
                  Text('趣味：〇〇'),
                  Row(
                    children: [
                      Text('一言：'),
                      Flexible(
                          child: Text(
                              'アプリ作ろうぜ！そういえばメッセージって長くなりがちだよね。そんな時も安心！Flexibleで囲ってあげれば、自動的にこんな感じで折り返してくれるよ〜すごいぜ〜〜。ちなみに改行をしたい場合は\nをつけるとできるよ！\n\n2個連続ももちろんオッケー！')),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.brown, width: 2),
              ),
              // ★：①ElevatedButtonを追加
              // ★：②カウントテキストを追加
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // ここにボタンが押された時の処理を書く
                    },
                    child: Text('いいね！'),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '0',
                    style: TextStyle(color: Colors.red[400]),
                  ),
                ],
              ),
              // ★：ここまで
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
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
