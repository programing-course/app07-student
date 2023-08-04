# **クイズアプリを作ろう 09**

## **結果をダイアログに表示しよう QuizListPage.class**

<br>

① answerDialog関数を作成  
② 結果のテキストを表示  
③ テキストボタンを作る  
④ answerSelect関数の中でansswerDialog関数を呼び出す  
⑤ ダイアログが表示された後の処理を設定  

<br>

#### **【ソースコード】**

```dart

// 省略

  // 答えが選択された時の処理
  void answerSelect() async {
    if (correctCheck(_listIndex, _selectedBtn) == true) {
      _resultText = "正解！";
      _correctCnt++;
    } else {
      _resultText = "ざんねん・・・";
    }

    // ★④ answerSelect関数の中でansswerDialog関数を呼び出す
    final rtext = await answerDialog();

    // ★⑤ ダイアログが表示された後の処理を設定
    if (rtext != null) {
      setState(() {
        _listIndex++; // 次の問題へ
        _selectedBtn = 0; // 選ばれたボタンの情報をリセット
      });
    }
  }

  // ★① answerDialog関数を作成
  dynamic answerDialog() {
    var rtn = showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // ★② 結果のテキストを表示
        content: Text("結果"),
        actions: [
          // ★③ テキストボタンを作る
          TextButton(
            onPressed: () {},
            child: Text("次の問題"),
          ),
        ],
      ),
    );
    return rtn; // 結果をお返し
  }

// 省略

```
