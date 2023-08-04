# **クイズアプリを作ろう 07**

## **選択肢を増やそう　 QuizListPage.class**

<br>

① for文を使って、選択肢ボタンを４つに増やす  
② 「_selectedBtn」の値を`i`に置き換える  
③ Mapのkey「answer`1`」「answer`2`」「answer`3`」「answer`4`」の数字の部分を変数`i`に置き換える  

<br>

#### **【ソースコード】 QuizListPage.class body内**

```dart

// 省略

      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: 150,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第${_listIndex + 1}問 / □問中'),
                  SizedBox(height: 10),
                  Text(quizlist[_listIndex]["question"]),
                ],
              ),
            ),
            SizedBox(height: 20),
            // ★① ElevatedButtonとSizedBoxをfor文で囲う　1~4まで繰り返す
            for (int i = 1; i <= 4; i++) ...{
              ElevatedButton(
                onPressed: () async {
                  // ★② ボタン番号をiに置き換える
                  _selectedBtn = i;
                },
                // ★③ 数字をiに置き換える
                child: Text(quizlist[_listIndex]["answer$i"]),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  fixedSize: Size(200, 50),
                ),
              ),
              SizedBox(height: 20),
            },
          ],
        ),
      ),

```
