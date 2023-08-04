# **クイズアプリを作ろう 0６**

## **選択肢ボタンの情報を管理しよう　QuizListPage.class**

<br>

① 変数「_selectedBtn」を作成し、初期値に０を代入  
② 選択肢ボタンが押されたら、ボタンの番号を_selectedBtnに代入する

<br>

#### **【ソースコード】**

```dart

// 省略

class QuizListPage extends StatefulWidget {
  const QuizListPage({super.key});

  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  int _listIndex = 0;
  // ★①　選択肢ボタンの番号
  int _selectedBtn = 0;

  List<Map<String, dynamic>> quizlist = [
    // 略
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('出題'),
        automaticallyImplyLeading: false,
      ),
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
            ElevatedButton(
              onPressed: () async {
                // ★②　何番目のボタンが押されたか代入
                _selectedBtn = 1;
              },
              child: Text(quizlist[_listIndex]["answer1"]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// 省略

```
