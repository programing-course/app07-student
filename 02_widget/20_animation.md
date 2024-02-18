# **20_簡単なアニメーション**


## **ライブラリを使ってみよう！**

「flutte_animate」ライブラリを使ってみよう  
ライブラリとは・・・よく使う機能を「部品」にして、簡単に使えるようにしたもの

<br><br>

### **ライブラリの準備**

①「flutter_animate」をインポート

```dart
import 'package:flutter_animate/flutter_animate.dart';
```

②pubspec.yamlにライブラリ追加

```dart

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_animate:　←ここ追加

```

③アニメーションしたいwidgetの後ろにアニメーションプロパティ追加

```
.animate().fadeIn(duration: 2000.ms),
```

使用例
```dart

child: ListView(
    children: [
        Image.asset(
        "images/cat001.jpg",
        width: 100,
        height: 100,
        ).animate().fadeIn(duration: 2000.ms),  //←ここ追加

        //省略
    ]
)


```

### **fadeIn　　fadeOut**

```
.animate().fadeIn(duration: 2000.ms),
```

```
.animate().fadeOut(duration: 2000.ms),
```