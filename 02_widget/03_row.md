# **自己紹介アプリを作ろう 03**

## **要素を横に並べよう！**

<br>

①最後のText()一言の部分を、Row()で囲う  
②Text()をもう一つ追加  

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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Text('名前：〇〇'),
                  Text('住み：〇〇'),
                  Text('趣味：〇〇'),
                  // ★：①最後のText()一言の部分を、Row()で囲う
                  Row(
                    children: [
                      // ★：②Text()をもう一つ追加
                      Text('一言：'), Text('〇〇'),
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
