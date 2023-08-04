# **クイズアプリを作ろう 04**

## **問題を表示しよう QuizListPage.class**

<br>

① Listから１問目のデータを表示する  
② Listから１問目の選択肢を表示する

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
              height: 200,
              color: Colors.yellow,
              child: Column(
                children: [
                  Text('第○問 / □問中'),
                  const SizedBox(height: 10),
                  // ★① 問題文表示 Text()内を変更
                  Text(quizlist[0]["question"]),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {},
              // ★② 選択肢表示 Text()内を変更
              child: Text(quizlist[0]["answer1"]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                fixedSize: Size(200, 50),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// 省略
```
