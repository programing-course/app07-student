# **クイズアプリを作ろう 12**

## **結果発表ページを表示しよう ResultPage.class**

<br>
 
① 表示の枠を作る  
② 結果表示の文字を作る  
③ 最初のページに戻るボタンを作る

<br>

#### **【ソースコード】**

```dart

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('結果発表'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        // ★① 表示の枠を作る ここから↓↓
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
          children: [
            // ★② 結果表示の文字を作る
            Text( // 文字
              "${widget._quizlistCnt}問中 ${widget._correctCnt}問正解", // 正解の数と、問題総数を表示
              style: TextStyle(
                fontSize: 30, // 文字の大きさを30pxに
              ),
            ),
            // ★③ 最初のページに戻るボタンを作る
            ElevatedButton( // ボタン
              onPressed: () { // ボタンを押したら
                Navigator.of(context).popUntil((route) => route.isFirst); // 最初のページへ
              },
              child: Text("もう一回"), // ボタンのテキスト
              style: ElevatedButton.styleFrom( // ボタンの見た目
                backgroundColor: Colors.orange, // 背景はオレンジ
                foregroundColor: Colors.white, // 文字の色は白
                fixedSize: Size(200, 50), // 幅200px 高さ50px
              ),
            )
          ],
        ),
        // ↑↑ ここまで
      ),
    );
  }
}

```
