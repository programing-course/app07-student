# **自己紹介アプリを作ろう 13**

## **メッセージ入力をつくろう！その2**

<br>

①変数textを作り、初期値を空白にする  
②onChangedの中に入力した文字列をtextに代入する処理を追加  
③変数sendTextを作り、初期値を空白にする  
④onPressedの中に送信アイコンが押されたら変数sendTextにtextを代入する  
⑤sendTextを画面に表示する

<br>

### **【ソースコード】**

- // ★ の箇所を修正しよう

```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var good = 0;
  // ★：①変数textを作り、初期値を空白にする
  String text = '';
  // ★：③変数sendTextを作り、初期値を空白にする
  String sendText = '';

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
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.brown, width: 2),
              ),
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Image.asset(
                    "images/cat.png",
                    width: 100,
                    height: 100,
                  ),
                  Text('名前：ぞえ'),
                  Text('住み：東京'),
                  Text('趣味：音楽'),
                  Row(
                    children: [
                      Text('一言：'),
                      Flexible(
                          child: Text(
                              'アプリ作ろうぜ！そういえばメッセージって長くなりがちだよね。そんな時も安心！Flexibleで囲ってあげれば、自動的にこんな感じで折り返してくれるよ〜すごいぜ〜〜。ちなみに改行をしたい場合は\nをつけるとできるよ！\n\n2個連続ももちろんオッケー！'))
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    good.toString(),
                    style: TextStyle(color: Colors.red[400]),
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 230,
                        child: TextField(
                          // ★：②onChangedの中に入力した文字列をtextに代入する処理を追加
                          onChanged: (String value) {
                            setState(
                              () {
                                text = value;
                              },
                            );
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
                          // ★：④onPressedの中に送信アイコンが押されたら変数sendTextにtextを代入する
                          setState(
                            () {
                              sendText = text;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // ★：⑤sendTextを画面に表示する
                  Text(sendText),
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
