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
