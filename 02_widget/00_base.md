# **自己紹介アプリを作ろう 00**

## **アプリのベースをつくる**

<br>

1ページにつき「情報用」と「中身用」2つのクラスを作る  

  
①アプリタイトルを設定  
②上のバー（appBar）に表示させるタイトルを設定  
③全体をCenterで中央揃えに  
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
      // ★：①アプリタイトルを設定
      title: 'Profile',
      theme: ThemeData(primarySwatch: Colors.blue),
      // ★：②上のバー（appBar）に表示させるタイトルを設定
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
        // ★：③全体をCenterで中央揃えに
        // ここにパーツ（Widget）を揃えていく
      ),
    );
  }
}

```
