# **クイズアプリを作ろう 16**

## **カウントダウンタイマーを作る 表示 QuizListPage**

<br>

① answerSelect関数の中に、countTimerを追加  
② 答えのボタンが押された時の処理を変更  
③ 変数_currentSecを表示


<br>

#### **【ソースコード】 QuizListPage answerSelect関数内**

```dart

  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      _resultText = "正解！";
      _correctCnt++;
    } else {
      _resultText = "ざんねん・・・";
    }

    final rtext = await answerDialog();

    if (rtext != null) {
      setState(() {
        _listIndex++;
        _selectedBtn = 0;
        // ★① answerSelect関数の中に、countTimerを追加
        countTimer();
      });
    }
  }

```

#### **【ソースコード】 QuizListPage for文で作成している選択肢ボタン**

```dart

for (int i = 1; i <= 4; i++) ...{
  ElevatedButton(
    onPressed: () async {
      // ★② 答えのボタンが押された時の処理を変更
      if (_selectedBtn != 0) { // 既にボタンが押されていたら、answerSelect関数を実行
        answerSelect();
      }
      _selectedBtn = i;
    },
    child: Text(quizlist[_listIndex]['answer$i']),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      fixedSize: Size(200, 50),
    ),
  ),
  SizedBox(height: 20),
},
Container(
  width: 50,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.pink, // 背景色
  ),
  child: Center(
    child: Text(
      // ★③ 変数_currentSecを表示
      _currentSec.toString(),
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  ),
),

```