# Todoアプリを作ろう 06


**リストの抽出と並び替え**

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

**【todo.dart】**

```dart

class _TodoListPageState extends State<TodoListPage> {
  double? _deviceWidth, _deviceHeight;

  //⭐️追加
  List<bool> _isState = List.generate(stateList.length, (index) => index == 0); //選択の状態を管理（初期値：１つ目のボタン）
  //⭐️追加
  var _selectbutton = 0; //どのボタンを選択したか

```

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

**【todo.dart】**

データ抽出

```dart

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
        DataSelect();//⭐️追加
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
              DataSelect();//⭐️追加
            });
          }
        },
        child: Icon(Icons.add),
      ),

```
