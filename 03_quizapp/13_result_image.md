# **クイズアプリを作ろう 13**

## **正解数によって画像を切り替える関数 ResultPage.class**

<br>

① Widget関数「resultImage」を作る（画像Widgetが返ってくる）  
② 全問正解の時のみ、画像を切り替える処理を設定  
③ Paddingを作り、中にresultImage関数を設定

<br>

#### **【ソースコード】**

```dart

class ResultPage extends StatefulWidget {
  ResultPage(this._quizlistCnt, this._correctCnt);
  int _quizlistCnt;
  int _correctCnt;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  // ★① Widget関数「resultImage」を作る（画像Widgetが返ってくる）  
  Widget resultImage() {
    // 画像のパスを入れる変数
    var imagePath;

    // ★② 全問正解の時のみ、画像を切り替える処理を設定
    if (widget._correctCnt == widget._quizlistCnt) {
      imagePath = "images/yeah.png";
    } else {
      imagePath = "images/yeah2.png";
    }

    return Image.asset(
      imagePath, // 設定された画像のパス
      width: 300, // 幅300px
      height: 300, // 高さ300px
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('結果発表'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget._quizlistCnt}問中 ${widget._correctCnt}問正解",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            // ★③ Paddingを作り、中にresultImage関数を設定
            Padding(
              padding: EdgeInsets.all(20),
              child: resultImage(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text("もう一回"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
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
