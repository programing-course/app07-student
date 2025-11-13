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

**⑤追加ボタン**

```dart

children: [
  Container(
  child: IconButton(
      icon: Icon(Icons.add_outlined),
      onPressed: () {
        setState(() {
            
            _titleController.add(TextEditingController(text: ''));
            category_count = _titleController.length;
          
        });
      }),
),

```

**⑥保存ボタン**

一覧の下に追加

**【setting.dart】**

```dart

TextButton(
  onPressed: () async {
    Save_Category();
  },
  child: Text('保存'),
)

```

**⑦関数追加**

**【setting.dart】**

```dart

Future<void> Save_Category() async {
    categorylist.clear();
    for (var i = 0; i < category_count; i++) {
      if (_titleController[i].text != "") {
        categorylist.add(_titleController[i].text);
      }
    }

    await saveData_categoryList();
  }

```


**【config.dart】**

categorylistのデータをコメントアウト

```dart
List<String> categorylist = [
  //"調味料",
  //"肉・魚",
  //"野菜",
  //"卵乳米",
  //"加工品",
  //"お菓子",
  //"日用品",
  //"その他",
  //"全て"
];

```

**⑧データ保存**

**【datasave.dart】**

```dart

Future<void> saveData_categoryList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(categorylist);
  await prefs.setString('categoryList', jsonString);
}

/// categoryList を読み込み
Future<void> loadData_categoryList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('categoryList');

  if (jsonString != null) {
    List<dynamic> jsonData = jsonDecode(jsonString);
    categorylist = jsonData.map((e) => e.toString()).toList();
  } else {
    categorylist = []; // データがない場合は空リスト
  }
}

```

**⑨データ呼び出し**

**【main.dart】**

```dart

import 'datesave.dart'; //⭐️保存

class _NaviAppState extends State<NaviApp> {
  int _selectedIndex = 0;

  void initState() {
    loadDate();
  }

  Future<void> loadDate() async {
    await loadData_categoryList();
  }

  //省略

}

```

**⑩カテゴリの追加は全ての前**

カテゴリの枠を追加するのは「全て」枠の上にする

**【setting.dart】**

```dart

Container(
  child: MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
        child: Icon(
          Icons.add_outlined,
        ),
        onTap: () async {
          setState(() {
            //⭐️修正
            _titleController.insert(categorylist.length - 1,
                TextEditingController(text: ''));
            category_count++;
          });
        }),
  ),
),

```

**11.色の追加**

**【setting.dart】**

```dart

void _showColorPicker(BuildContext context, int index) {
    Color pickerColor = ColorList[index];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select a Color"),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                setState(() {
                  pickerColor = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  ColorList[index] = pickerColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

```