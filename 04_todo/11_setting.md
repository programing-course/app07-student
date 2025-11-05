# Todoアプリを作ろう 11


**設定画面を作る**

**①カテゴリーデータの枠を作る**

**【setting.dart】**


```dart

import 'package:flutter/material.dart';
import 'config.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late List<TextEditingController> _titleController;

void initState() {
  _titleController = categorylist.map((value) => TextEditingController(text: value)).toList();
}
@override
  void dispose() {
    for (final c in _titleController) {
      c.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: Center(
        child:Container(
          child: Column(
            children: [
              Container(
                child: Text(''),
              ),
              Container(
                child: Column(
                  children: [
                    for (var i = 0;i < categorylist.length;i++)... {
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: TextField(
                                controller: _titleController[i],
                              )
                            ),
                            Icon(Icons.delete_outline)
                          ],
                        ),
                      )
                    }
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

```

**②削除ボタンの処理**

```dart

MouseRegion(
  cursor: SystemMouseCursors.click,
  child: GestureDetector(
      child: Icon(
        Icons.delete_outlined,
      ),
      onTap: () async {
        setState(() {
          Deleate_category(i);
        });
      })),

```

**③関数作成**

```dart

Future<void> Deleate_category(int index) async {
  _titleController.removeAt(index);

}

```

このままだとエラーになる

**④categoryListの数を変数にする**

```dart

int category_count = 0; //⭐️追加

void initState() {
    _titleController = categorylist
        .map((value) => TextEditingController(text: value))
        .toList();
    category_count = categorylist.length; //⭐️追加
  }

  //省略

  Future<void> Deleate_category(int index) async {
    _titleController.removeAt(index);

    category_count--; //⭐️追加
  }

  //省略

  for (var i = 0; i < category_count; i++) ...{ //⭐️修正
    Container(
      child: Row(
        children: [
          Container(
              width: 200,
              child: TextField(
                controller: _titleController[i],
              )),
          MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  child: Icon(
                    Icons.delete_outlined,
                  ),
                  onTap: () async {
                    setState(() {
                      Deleate_category(i);
                    });
                  })),
        ],
      ),
    )
  }

```
