# **クイズアプリを作ろう 11**

## **最終問題のときだけ、結果発表ページに飛ばそう QuizListPage.class**

<br>

① onPressedの中にif文を追加し、lastCheck関数を使って条件分岐  
② ResultPageに、総問題数と正解数を引き渡す  
③ ResultPageで、総問題数と正解数を受け取る  
④ ResultPageで、総問題数と正解数を使えるようにする  

<br>

#### **【ソースコード】QuizListPage answerDialog関数**

```dart

// 省略
  dynamic answerDialog() {
    var rtn = showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(_resultText),
        actions: [
          TextButton(
            onPressed: () {
              // ★① onPressedの中にif文を追加し、lastCheck関数を使って条件分岐
              if (lastCheck(_listIndex) == true) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      // ★② ResultPageに、総問題数と正解数を引き渡す
                      return ResultPage(_quizlistCnt, _correctCnt);
                    },
                  ),
                );
              } else {
                Navigator.pop(context, _resultText);
              }
            
            // ↑↑ここまで

            },
            child: Text((lastCheck(_listIndex)) ? "結果発表" : "次の問題"),
          ),
        ],
      ),
    );
    return rtn; // 結果をお返し
  }

```

  

#### **【ソースコード】ResultPage**

```dart

class ResultPage extends StatefulWidget {
  // const ResultPage({super.key}); を消す
  // ★③ ResultPageで、総問題数と正解数を受け取る  
  ResultPage(this._quizlistCnt, this._correctCnt);
  // ★④ ResultPageで、総問題数と正解数を使えるようにする 
  int _quizlistCnt;
  int _correctCnt;

  @override
  _ResultPageState createState() => _ResultPageState();
}


```