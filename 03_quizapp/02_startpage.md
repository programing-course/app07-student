# **クイズアプリを作ろう 02**

## **スタートページをつくろう　StartPage.class**

<br>

①〜③スタートボタンのベースを作る  
④「START」ボタン押下時の処理を完成させる  
⑤トップ画像を入れる(pubspec.yamlの設定は、02_widget/07_image.mdを参考)  

<br>

#### **【ソースコード】**

```dart
// 省略

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('クイズアプリ'),
      ),
      body: Center(
        // ★①コピペOK ↓ここから
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ★★⑤★★
            ElevatedButton(
              onPressed: () {
                ★★②★★
              },
              child: ★★③★★,
              style: ElevatedButton.styleFrom(
                ★★④★★
              ),
            ),
          ],
        ),
        //↑ここまで
      ),
    );
  }
}

// 省略

```
#### ★★②★★の部分を下のコードに置き換えよう

ボタンが押された時の処理

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) {
      return QuizListPage();
    },
  ),
);
```

#### ★★③★★の部分を下のコードに置き換えよう

ボタンの文字を設定

```dart
const Text('START'),
```

#### ★★④★★の部分を下のコードに置き換えよう

ボタンのデザイン（参考）

```dart
backgroundColor: Colors.pink,
foregroundColor: Colors.white,
fixedSize: Size(200, 50),
```

#### ★★⑤★★の部分を下のコードに置き換えよう

画像

```dart
Image.asset(
    "images/quiz.png",
    width: 200,
),
```


#### **【完成コード】**

```dart
class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('クイズアプリ'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/quiz.png",
              width: 200,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return QuizListPage();
                    },
                  ),
                );
              },
              child: const Text('START'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
            )
          ],
        ),

      ),
    );
  }
}
```
