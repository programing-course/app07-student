# **自己紹介アプリを作ろう 07**

## **画像を入れよう！**

<br>

### **画像の準備**
①画像をアップロード  
「profile」フォルダの下に「images」フォルダを作成  
その中に使いたい画像を入れる  
②「pubspec.yaml」の設定  
一番下（flutter ブロックの中）のコメントアウトを外し、以下に修正

```dart
assets:
  - images/
```

③imageを追加

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
          children: [
            Container(
              width: 300,
              height: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.brown, width: 2),
              ),
              child: Column(
                children: [
                  // ★：③imageを追加
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
                      Text('〇〇'),
                    ],
                  ),
                ],
              ),
            ),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}

```
