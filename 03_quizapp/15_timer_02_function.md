# **クイズアプリを作ろう 15**

## **カウントダウンタイマーを作る 変数と関数作成 QuizListPage**

<br>

① 一番上に「import 'dart:async';」を追加
② 変数「_currentSec」を作り、10を代入（10秒のタイマー）  
③ タイマー用の関数を3つ作成  
- initState：初期化用  
- timeOver：時間切れの処理  
- countTimer：タイマーを起動  

<br>

#### **【ソースコード】 一番上**

```dart

// ★① 一番上に「import 'dart:async';」を追加
import 'dart:async';

import 'package:flutter/material.dart';
import 'quizlist.dart';


```


#### **【ソースコード】 QuizListPage**

```dart

class _QuizListPageState extends State<QuizListPage> {
  // 変数リスト
  int _quizlistCnt = quizlist.length; // クイズの数
  int _correctCnt = 0; // 何問正解しているか
  int _listIndex = 0; // 今何問目か
  int _selectedBtn = 0; // 選ばれた答え
  // ★② 変数「_currentSec」を作り、10を代入（10秒のタイマー）
  int _currentSec = 10; // タイマー用 制限時間

  String _resultText = ""; // 正解 or 不正解


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

  // ★③ 初期化用関数
  @override
  void initState() {
    super.initState();
    countTimer();
  }

  // ★③ 時間切れの処理用関数
  void timeOver() async {
    _resultText = "タイムオーバー"; // 結果の文字を「タイムオーバー」に

    // ダイアログ表示
    final rtext = await answerDialog();

    if (rtext != null) { // ダイアログが表示されたら
      setState(() {
        _listIndex++; // 問題カウントを+1して次の問題へ
        _currentSec = 10; // タイマーの制限時間をリセット
        _selectedBtn = 0; // 選ばれた答えをリセット
        countTimer(); //タイマー再スタート
      });
    }
  }

  // ★③タイマーを起動する関数
  Timer countTimer() {
    return Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_selectedBtn == 0) { // ボタンが押されていない場合
          if (_currentSec == 0) { // 時間切れなら
            timer.cancel(); // タイマーをキャンセル
            timeOver(); // タイムオーバー関数を実行
          } else { // 時間がまだ残っていれば
            setState(() {
              _currentSec--; // 時間を減らしていく
            });
          }
        } else { // ボタンが押された場合
          timer.cancel(); // タイマーをキャンセル
          answerSelect(); // ボタンが押された時の処理を実行
        }
      },
    );
  }
}

```