# Todoアプリを作ろう 12


**グラフを表示する**

**①グラフの枠を作る**

**【pubspec.yaml】**

```dart

fl_chart: ^0.71.0

```

**【home.dart】**

```dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'config.dart';
import 'todo.dart';
import 'datesave.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // 年・月だけを使うので day=1 に固定
    _currentMonth = DateTime(now.year, now.month, 1);
    loadDate();
  }

  Future<void> loadDate() async {
    await load_todoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '達成度',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // 円グラフ部分
            Expanded(
              child: Center(
                child: MonthlyAchievementPieChart(
                  todoList: todoList, // todo.dart のリストをそのまま渡す
                  targetMonth: _currentMonth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

**②円グラフのウェジットを作る**

**【home.dart】**

一番下に追加

```dart

class MonthlyAchievementPieChart extends StatelessWidget {
  final List<Map<String, dynamic>> todoList;
  final DateTime targetMonth; // 表示したい月

  const MonthlyAchievementPieChart({
    super.key,
    required this.todoList,
    required this.targetMonth,
  });

  @override
  Widget build(BuildContext context) {
    final summary = calcMonthlySummary(todoList, targetMonth);

    // タスク0件のときはメッセージだけ出す
    if (summary.total == 0) {
      return Text(
        'この月のタスクはありません',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[700],
        ),
      );
    }

    final double doneValue = summary.done.toDouble();
    final double notDoneValue = summary.notDone.toDouble();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${targetMonth.year}年${targetMonth.month}月の達成度',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: [
                PieChartSectionData(
                  value: doneValue,
                  title: '達成\n${summary.done}/${summary.total}',
                  radius: 60,
                  showTitle: true,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  color: Colors.green,
                ),
                PieChartSectionData(
                  value: notDoneValue,
                  title: '未達成\n${summary.notDone}',
                  radius: 60,
                  showTitle: true,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '達成率: ${(summary.done / summary.total * 100).toStringAsFixed(1)}%',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}

// ====== 集計用クラス & 関数 ======

class MonthlySummary {
  final int total;
  final int done;
  final int notDone;

  MonthlySummary({
    required this.total,
    required this.done,
  }) : notDone = total - done;
}

MonthlySummary calcMonthlySummary(
  List<Map<String, dynamic>> todoList,
  DateTime targetMonth,
) {
  // 対象月のデータだけ抽出
  final monthlyTodos = todoList.where((item) {
    final DateTime date = item['date'] as DateTime;
    return date.year == targetMonth.year && date.month == targetMonth.month;
  }).toList();

  final int total = monthlyTodos.length;
  final int done = monthlyTodos.where((item) => item['check'] == true).length;

  return MonthlySummary(total: total, done: done);
}

```

**③月の切り替え**

```dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO管理'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '達成度',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            //⭐️追加 ＜ 〇〇年〇月 ＞ のヘッダー（山括弧がボタン）
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ＜ ボタン
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _goToPreviousMonth,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '＜',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // 年月表示（タップ不可）
                Text(
                  '${_currentMonth.year}年${_currentMonth.month}月',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 8),

                // ＞ ボタン
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: _goToNextMonth,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '＞',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 円グラフ部分
            Expanded(
              child: Center(
                child: MonthlyAchievementPieChart(
                  todoList: todoList, // todo.dart のリストをそのまま渡す
                  targetMonth: _currentMonth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

```

```dart

  void _goToPreviousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _goToNextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

```