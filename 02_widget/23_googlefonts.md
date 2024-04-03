# **23_googlefonts**


## **googlefontsライブラリを使ってみよう！**

<br><br>


### **ライブラリの準備**

①pubspec.yamlにライブラリ追加

古いバージョンや最新バージョンだとエラーになる場合がある  
flutterSDKとの相性が微妙

```dart

dependencies:
  flutter:
    sdk: flutter
  google_fonts: 6.1.0　←ここ追加

```

インデントを合わせる  
[google_fonts: 6.1.0]の上に他のライブラリが指定されていることもあります

<br><br>

②「google_fonts」をインポート

```dart
import 'package:google_fonts/google_fonts.dart';
```

importでエラーになる場合は、VSCode ターミナルに下記を打ってエンター
```dart
  flutter pub add google_fonts
```

<br><br>

③`theme:ThemeData` に適用するフォントを指定

**ページ全体に適用する**

```dart
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    //googleフォントを指定
    theme: ThemeData(
      textTheme: GoogleFonts.sawarabiMinchoTextTheme(
        Theme.of(context).textTheme,
      ),
      colorScheme:
          ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 190, 26, 174)),
      useMaterial3: true,
    ),
    home: const ToDoPage(title: 'やること'),
  );
}
```

**一部に適用する**

```dart

Text(
  'はじめる',
  style: GoogleFonts.sawarabiMincho(
    textStyle: Theme.of(context).textTheme.headline4
    color: Color(0xFF000000),
    fontSize: 20.0,
  ),
),

```
