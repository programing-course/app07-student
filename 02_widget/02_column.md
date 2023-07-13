# **自己紹介アプリを作ろう 02**

## **要素を縦に並べよう！**

<br>

①Container⇨Columnに変更  
②Child⇨Childrenに変更, Container()を3つ並べて作る  
③1つめのContainer()の中に、childを設定、Column()を作成  
④childrenを設定,Text()を並べる

**ポイント**  
- Containerは、要素を1つ入れられる
- Columnは、要素を複数入れられて、縦に並ぶ
- Rowは、要素を複数入れられて、横に並ぶ

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
        // ★：①Container⇨Columnに変更
        child: Column(
          // ★：②Child⇨Childrenに変更, Container()を3つ並べて作る
          children: [
            Container(
              // ★：③1つめのContainer()の中に、childを設定、Column()を作成
              child: Column(
                // ★：④childrenを設定,Text()を並べる
                children: [
                  Text('名前：〇〇'),
                  Text('住み：〇〇'),
                  Text('趣味：〇〇'),
                  Text('ひとこと'),
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
