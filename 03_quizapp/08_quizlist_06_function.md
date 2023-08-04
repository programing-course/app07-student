# **クイズアプリを作ろう 08**

## **回答後の処理をつくろう　関数にまとめる QuizListPage.class**

<br>

① 変数を3つ作成  
- _quizlistCnt：全クイズの数
- _correctCnt：正解数
- _resultText：正解or不正解の文字用
  
② 関数を3つ作成  
- correctCheck：正解 / 不正解のチェック
- lastCheck：今が最終問題かのチェック
- answerSelect：答えが選択された時の処理

③ 変数と関数を設定
- _quizlistCntをテキスト内に
- answerSelectをonPressed内に


<br>

#### **【ソースコード】**

```dart

class _QuizListPageState extends State<QuizListPage> {
  // ★① 変数を3つ作成
  int _quizlistCnt = quizlist.length; // クイズの数
  int _correctCnt = 0; // 何問正解しているか
  int _listIndex = 0; // 今何問目か
  int _selectedBtn = 0; // 選ばれた答え

  String _resultText = ""; // 正解 or 不正解

  // ★② 関数を3つ作成
  // 正解 / 不正解のチェック
  bool correctCheck(now, selected) {
    if (quizlist[now]["correct"] == selected) {
      return true;
    }
    return false;
  }

  // 今が最終問題かのチェック
  bool lastCheck(now) {
    if (now == _quizlistCnt - 1) {
      return true;
    }
    return false;
  }

  // 答えが選択された時の処理
  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) { // 合っていたら
      _resultText = "正解！";
      _correctCnt++;
    } else { // 合っていなかったら
      _resultText = "ざんねん・・・";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('出題'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.yellow,
              child: Column(
                children: [
                  // ★ ③_quizlistCnt変数を設定
                  Text('第${_listIndex + 1}問 / ${_quizlistCnt}問中'),
                  SizedBox(height: 10),
                  Text(quizlist[_listIndex]['question']),
                ],
              ),
            ),
            SizedBox(height: 20),
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () async {
                  _selectedBtn = i;
                  // ★ ③answerSelect関数を設定
                  answerSelect();
                },
                child: Text(quizlist[_listIndex]['answer$i']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  fixedSize: Size(200, 50),
                ),
              ),
              SizedBox(height: 20),
            }
          ],
        ),
      ),
    );
  }
}

```
