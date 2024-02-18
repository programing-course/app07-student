# **20_簡単なアニメーション**


## **ライブラリを使ってみよう！**

「flutte_animate」ライブラリを使ってみよう  
ライブラリとは・・・よく使う機能を「部品」にして、簡単に使えるようにしたもの

<br><br>

### **ライブラリの準備**

①「flutter_animate」をインポート

```dart
import 'package:flutter_animate/flutter_animate.dart';
```

②pubspec.yamlにライブラリ追加

```dart

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_animate:　←ここ追加

```

③アニメーションしたいwidgetの後ろにアニメーションプロパティ追加

```
.animate().fadeIn(duration: 2000.ms),
```

使用例
```dart

child: ListView(
    children: [
        Image.asset(
        "images/cat001.jpg",
        width: 100,
        height: 100,
        ).animate().fadeIn(duration: 2000.ms),  //←ここ追加

        //省略
    ]
)


```

### **fadeIn　　fadeOut**

```
.animate().fadeIn(duration: 2000.ms),
```

```
.animate().fadeOut(duration: 2000.ms),
```


### **【ソースコード】**
```dart

import 'package:flutter/material.dart';

// flutte_animateパッケージを読み込み
import 'package:flutter_animate/flutter_animate.dart'; //追加

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
  String text = '';
  String sendText = '';
  final messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  ).animate().fadeIn(duration: 2000.ms), //追加
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("名前"),
                      SizedBox(width: 20),
                      Text(
                        "トライさん",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("住み"), SizedBox(width: 20), Text("東京都")],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("趣味"),
                      SizedBox(width: 20),
                      Text("ゲーム\n散歩")
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("一言"),
                      SizedBox(width: 20),
                      Flexible(
                        child: Text(
                            "はじめまして！\nそういえばメッセージって長くなりがちだよね。そんな時も安心！Flexibleで囲ってあげれば、自動的にこんな感じで折り返してくれるよ〜。ちなみに改行をしたい場合は\nをつけるとできるよ！\n\n2個連続ももちろんオッケー！"),
                      ),
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
                    "$good",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                  SizedBox(width: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return IntroDuction();
                          },
                        ),
                      );
                    },
                    child: Text('もっと見る'),
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
                          controller: messageTextController,
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
                          messageTextController.clear();
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