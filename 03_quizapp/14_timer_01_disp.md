# **クイズアプリを作ろう 14**

## **カウントダウンタイマーを作る 表示 QuizListPage**

<br>

① カウントダウン表示用Containerを作る  

<br>

#### **【ソースコード】 QuizListPage body内**

```dart

      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第${_listIndex + 1}問 / ${_quizlistCnt}問中'),
                  SizedBox(height: 10),
                  Text(quizlist[_listIndex]['question']),
                ],
              ),
            ),
            SizedBox(height: 20),
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () async {
                  _selectedBtn = i;
                  answerSelect();
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

            // ★① カウントダウン表示用Containerを作る ↓↓ここから
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // 丸
                color: Colors.pink, // 背景色
              ),
              child: Center(
                child: Text(
                  "10",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white, // 文字色
                  ),
                ),
              ),
            ),
          // ↑↑ ここまで
          
          ],
        ),
      ),

```
