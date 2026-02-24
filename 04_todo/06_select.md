# Todoアプリを作ろう 06


**リストの抽出と並び替え**

**①抽出ボタンの追加**

**【todo.dart】**

Toggleボタン、ソートボタンの追加

```dart

  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: ToggleButtons(
          color: Color.fromARGB(255, 30, 186, 128),
          fillColor: Color.fromARGB(255, 104, 200, 101),
          borderColor: Color.fromARGB(255, 0, 113, 4),
          splashColor: Color.fromARGB(255, 171, 205, 159),
          selectedBorderColor: const Color.fromARGB(255, 40, 198, 151),
          selectedColor: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          isSelected: _isState,
          onPressed: (index) {
            setState(() {
              for (var i = 0; i < _isState.length; i++) {
                if (i == index) {
                  _isState[i] = true; //選択の状態を更新
                  _selectbutton = index; //選択されたボタン
                } else {
                  _isState[i] = false;
                }
              }
              // DataSelect();
            });
          },
          children: [
            for (var i = 0; i < stateList.length; i++) ...{
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('${stateList[i]}'),
              ),
            }
          ],
        ),
      ),
      SizedBox(width: 30),
      Container(
        child: GestureDetector(
          onTap: () {
            setState(() {
              sortkey = "star";
              sort(displaylist, sortkey);
            });
          },
          child: Icon(
            Icons.swap_vertical_circle_outlined,
          ),
        ),
      ),
      Container(
        child: Text("★"),
      ),
      SizedBox(width: 30),
      Container(
        child: GestureDetector(
          onTap: () {
            setState(() {
              sortkey = "date";
              sort(displaylist, sortkey);
            });
          },
          child: Icon(
            Icons.swap_vertical_circle_outlined,
          ),
        ),
      ),
      Container(
        child: Text("日付"),
      )
    ],
  ),

```

**②変数宣言**

**【config.dart】**

```dart

List<Map<String, dynamic>> todoList = [];
//⭐️表示用のリスト
List<Map<String, dynamic>> displaylist = [];
//⭐️状態のリスト
List<String> stateList = ["買うもの", "★付き", "済み", "全て"];
//⭐️追加
String sortkey = "";

```

**③変数宣言**

**【todo.dart】**

```dart

class _TodoListPageState extends State<TodoListPage> {
  double? _deviceWidth, _deviceHeight;

  //⭐️追加
  List<bool> _isState = List.generate(stateList.length, (index) => index == 0); //選択の状態を管理（初期値：１つ目のボタン）
  //⭐️追加
  var _selectbutton = 0; //どのボタンを選択したか

```

**④並び替えのプログラム**

 - 【check】済データ>日付の昇順
 - 【start】⭐️データ>日付の昇順
 - 【date】日付の昇順

**【config.dart】**

```dart

// ----- todoListを並び替え -----
// ----------------------------
Future<void> sort(agelist, agekey) async {
  print("sort");
  print(agelist);

  if (agekey == "check") {
    agelist.sort((a, b) {
      // キー: checkで並び替え（falseが上）
      int checkComparison =
          (a['check'] == false ? 0 : 1).compareTo(b['check'] == false ? 0 : 1);
      if (checkComparison != 0) {
        return checkComparison;
      }
      // キー: dateで並び替え（昇順）
      return (a['date'] as DateTime).compareTo(b['date'] as DateTime);
    });
  } else if (agekey == "star") {
    agelist.sort((a, b) {
      // キー: starで並び替え（trueが上）
      int checkComparison =
          (a['star'] == true ? 0 : 1).compareTo(b['star'] == true ? 0 : 1);
      if (checkComparison != 0) {
        return checkComparison;
      }

      // キー: dateで並び替え（昇順）
      return (a['date'] as DateTime).compareTo(b['date'] as DateTime);
    });
  } else if (agekey == "date") {
    agelist.sort((a, b) {
      // キー: dateで並び替え（昇順）
      return (a['date'] as DateTime).compareTo(b['date'] as DateTime);
    });
  } else {
    agelist.sort((a, b) {
      // キー: dateで並び替え（昇順）
      return (a['date'] as DateTime).compareTo(b['date'] as DateTime);
    });
  }
}

```

**⑤並び替え後の表示**

**【todo.dart】**

データ保存用のtodoListと表示のdisplaylist

```dart

//省略

  Future<void> loadDate() async {
    await load_todoList();
    sortkey = "check";
    //⭐️追加　元のデータlistで並び替え
    await sort(todoList, sortkey);
    //⭐️　表示ようのlistに入れる
    setState(() {
      displaylist = todoList.where((todo) => todo['check'] == false).toList();
    });
  }

  //省略

  child: ListView.builder(
    itemCount: displaylist.length, //⭐️修正
    itemBuilder: (context, index) {
      return GestureDetector(
          onTap: () async {
            var RtnText = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogPage(displaylist[index]['idx']); //⭐️修正
                });
            if (RtnText != null) {
              setState(() {});
            }
          },
          child: Card(
            child: ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Icon(Icons.star_outlined,
                      color: displaylist[index]['star'] //⭐️修正
                          ? Colors.red
                          : Colors.grey),
                ),
                Container(
                  child: Text(
                      '${displaylist[index]['date'].month}/${displaylist[index]['date'].day}'), //⭐️修正
                ),
                Container(
                  width: 300,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(displaylist[index]['title']), //⭐️修正
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(displaylist[index]['memo']), //⭐️修正
                      )
                    ],
                  ),
                ),
                Container(
                  width: 70,
                  child: Checkbox(
                      value: displaylist[index]['check'], //⭐️修正
                      onChanged: (value) {}),
                ),
              ],
            )
          ),
        )
      );
    }
  ),

```

**⑥データ抽出**

```dart

//省略

//⭐️ 選択されたボタンにより、表示するデータを切り替える
  void DataSelect() {
    sort(todoList, sortkey);
    if (_selectbutton == 0) {
      displaylist = todoList.where((todo) => todo['check'] == false).toList();
    } else if (_selectbutton == 1) {
      displaylist = todoList
          .where((todo) => todo['star'] == true && todo['check'] == false)
          .toList();
    } else if (_selectbutton == 2) {
      displaylist = todoList.where((todo) => todo['check'] == true).toList();
    } else {
      sort(todoList, "date");
      displaylist = todoList;
    }
  }

//省略

Container(
  child: ToggleButtons(
    color: Color.fromARGB(255, 30, 186, 128),
    fillColor: Color.fromARGB(255, 104, 200, 101),
    borderColor: Color.fromARGB(255, 0, 113, 4),
    splashColor: Color.fromARGB(255, 171, 205, 159),
    selectedBorderColor: const Color.fromARGB(255, 40, 198, 151),
    selectedColor: Colors.white,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    isSelected: _isState,
    onPressed: (index) {
      setState(() {
        for (var i = 0; i < _isState.length; i++) {
          if (i == index) {
            _isState[i] = true; //選択の状態を更新
            _selectbutton = index; //選択されたボタン
          } else {
            _isState[i] = false;
          }
        }
        DataSelect(); //⭐️追加
      });
    },
    children: [
      for (var i = 0; i < stateList.length; i++) ...{
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('${stateList[i]}'),
        ),
      }
    ],
  ),
),

//省略

floatingActionButton: FloatingActionButton(
  onPressed: () async {
    var RtnText = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogPage(-1);
        });
    if (RtnText != null) {
      setState(() {
        DataSelect(); //⭐️追加
      });
    }
  },
  child: Icon(Icons.add),
),


```