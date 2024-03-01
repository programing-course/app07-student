# **22_外部リンクする**


## **url_launcher」ライブラリを使ってみよう！**

<br><br>

【参考サイト】https://qiita.com/ryota47/items/0cd30257f063c06df1b8

<br><br>

### **ライブラリの準備**

①pubspec.yamlにライブラリ追加

```dart

dev_dependencies:
  flutter_test:
    sdk: flutter
  url_launcher: ^6.1.5　←ここ追加

```

インデントを合わせる  
[url_launcher: ^6.1.5]の上に他のライブラリが指定されていることもあります

<br><br>

②「url_launcher」をインポート

```dart
import 'package:url_launcher/url_launcher.dart';
```

importでエラーになる場合は、VSCode ターミナルに下記を打ってエンター
```dart
  flutter pub get
```

<br><br>

③該当のボタンの `onPressed:` で外部リンク関数を呼び出す

```dart
ElevatedButton(
  onPressed: () {
    _launchInApp(); //←ここ追加
  },
  child: Text('外部サイトに飛ばす！'),
),
```

④関数を追加　URLを追加
プログラムの一番下（クラスの外側）

```dart

_launchInApp() async {
  const url = '飛ばしたいサイトのURL';
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
    );
  } else {
    throw 'このURLにはアクセスできません';
  }
}
```

使用例
```dart

class _IntroDuction extends State<IntroDuction> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade50,
      appBar: AppBar(
        title: Text("うちのねこ"),
      ),
      body: Center(
          child: Container(
        width: 400,
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: Text(
                "我が家の猫を紹介します",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              child: Text(
                  "名前はモコ\nお昼寝大好き!いつも日向ぼっこしています。\nお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好きお昼寝大好き"),
            ),
            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  _launchInApp();
                },
                child: Text('原神のサイト'),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('戻る'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

_launchInApp() async {
  const url = 'https://genshin.hoyoverse.com/ja';
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
    );
  } else {
    throw 'このURLにはアクセスできません';
  }
}

```
