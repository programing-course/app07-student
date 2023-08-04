# **クイズアプリを作ろう 10**

## **次の問題を表示する QuizListPage.class**

<br>

① 結果の文字を変数に変更  
② onPressdで画面に戻る処理を追加（popで戻る）  
③ 最終問題だったらボタンのテキストを変更

<br>

#### **【ソースコード】 QuizListPage answerDialog関数**

```dart
// 省略

  dynamic answerDialog() {
    var rtn = showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // ★① 結果の文字を変数に変更
        content: Text(_resultText),
        actions: [
          TextButton(
            onPressed: () {
              // ★② onPressdで画面に戻る処理を追加（popで戻る）
              Navigator.pop(context, _resultText);
            },
            // ★③ 最終問題だったらボタンのテキストを変更
            child: Text((lastCheck(_listIndex)) ? "結果発表" : "次の問題"),
          ),
        ],
      ),
    );
    return rtn; // 結果をお返し
  }

// 省略

```
