# **クイズアプリを作ろう 17**

## **出来上がったクイズアプリをアレンジしよう**

<br>

**①ヒントボタンを作る** 
- quizlist.dartに「hint」を追加
- _hint という変数を作る
- 問題文表示領域の高さを200にする
- ヒントボタンと、表示するTextウィジェット作る
- ヒントボタンが押されたら_hint にヒントを代入
- timeOver関数と、answerSelect関数の中で、_hintを初期化

<br>

**②現在までの正解数を表示させる**
- Rowを作る
- ひとつめに● * 正解数
- ふたつめに× * 今何問目か - 正解数
- 色などをよしなに

<br>

**③正解や結果が最後にまとめて表示されるようにする**
- Containerを作る
- 幅、高さなどを設定
- 子要素にListViewを入れる
- Rowを作り「問題」「正解」のテキストを表示
- for文を使って、クイズの問題と正解をRowの中に表示
- 色などをよしなに


<br>

#### **【ソースコード】 ①ヒントボタンを作る**


**quizlist.dart**

```dart
{
    "question": "キリンの舌の長さはどれくらいでしょう？",
    "answer1": "25cm",
    "answer2": "45cm",
    "answer3": "65cm",
    "answer4": "85cm",
    "correct": 2,
    "hint": "顔の大きさを思い浮かべてみると良いかも", // ★ヒントを追加
},

```

**quizlist.dart _QuizListPageState**

```dart

  // 変数リスト
  int _quizlistCnt = quizlist.length;
  int _correctCnt = 0;
  int _listIndex = 0;
  int _selectedBtn = 0;
  int _currentSec = 10;

  String _resultText = "";
  String _hint = ""; // ★ヒント用の変数追加

```

**quizlist.dart _QuizListPageState body**

```dart

  Container(
    padding: const EdgeInsets.all(20),
    width: double.infinity,
    height: 200, // ★高さを変える
    color: Colors.yellow,
    child: Column(
      children: [
        Text('第${_listIndex + 1}問 / ${_quizlistCnt}問中'),
        SizedBox(height: 10),
        Text(quizlist[_listIndex]["question"]),
        // ★ヒントここから
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _hint = quizlist[_listIndex]["hint"];
          },
          child: Text("ヒント"),
        ),
        Text(_hint),
        // ★ヒントここまで
      ],
    ),
  ),

```

**quizlist.dart _QuizListPageState answerSelect()関数**

```dart

  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      _resultText = "正解!";
      _correctCnt++;
    } else {
      _resultText = "ざんねん…";
    }

    final rtext = await answerDialog();

    if (rtext != null) {
      setState(() {
        _listIndex++;
        _selectedBtn = 0;
        _currentSec = 10;
        _hint = ""; // ★ヒントの文字を初期化
        countTimer();
      });
    }
  }

```

**quizlist.dart _QuizListPageState timeOver()関数**

```dart

  void timeOver() async {
    _resultText = "タイムオーバー";

    final rtext = await answerDialog();

    if (rtext != null) {
      setState(() {
        _listIndex++;
        _currentSec = 10;
        _selectedBtn = 0;
        _hint = ""; // ★ヒントの文字を初期化
        countTimer();
      });
    }
  }

```

#### **【ソースコード】 ②現在までの正解数を表示させる**

**quizlist.dart _QuizListPageState body**

```dart

  Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      height: 200,
      color: Colors.yellow,
      child: Column(
        children: [
          Text('第${_listIndex + 1}問 / ${_quizlistCnt}問中'),
          SizedBox(height: 10),

          // ★今までの正解数表示 ここから
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "●" * _correctCnt,
                style: TextStyle(color: Colors.red),
              ),
              Text(" / "),
              Text(
                "×" * (_listIndex - _correctCnt),
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          // ★今までの正解数表示 ここまで
          
          SizedBox(height: 10),
          Text(quizlist[_listIndex]["question"]),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _hint = quizlist[_listIndex]["hint"];
            },
            child: Text("ヒント"),
          ),
          Text(_hint),
        ],
      ),
    ),

```

#### **【ソースコード】 ③正解や結果が最後にまとめて表示されるようにする**

**quizlist.dart _ResultPageState body**

```dart

  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        // ★正解発表ここから
        Container(
          width: 400,
          height: 200,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "問題",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "正解",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              SizedBox(height: 10),
              for (int i = 0; i <= 4; i++) ...{
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child:
                            Text("${i + 1} / ${quizlist[i]["question"]}")),
                    SizedBox(width: 30),
                    Flexible(
                        child: Text(
                      quizlist[i]["answer${quizlist[i]["correct"]}"],
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.right,
                    )),
                  ],
                ),
                SizedBox(height: 20),
              },
            ],
          ),
        ),
        // ★正解発表ここまで
        
        Text(
          "${widget._quizlistCnt}問中 ${widget._correctCnt}問正解",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
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

```