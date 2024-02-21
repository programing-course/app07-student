# **20_簡単なアニメーション**


## **ライブラリを使ってみよう！**

「carousel_slider」ライブラリを使ってみよう  
ライブラリとは・・・よく使う機能を「部品」にして、簡単に使えるようにしたもの

<br><br>

### **ライブラリの準備**

①pubspec.yamlにライブラリ追加

```dart

dependencies:
  flutter:
    sdk: flutter
  flutter_animate:
  carousel_slider: ^4.2.1　←ここ追加

```

②「carousel_slider」をインポート

```dart
import 'package:carousel_slider/carousel_slider.dart';
```

③スライダーを入れたい場所に設置

```
  CarouselSlider(
    items: [
      //スライドさせたいものをカンマ区切りで追加
      <widget①>,
      <widget②>,
      <widget③>,
    ],
    options: CarouselOptions(
      height: 300,//高さ
      initialPage: 0,//最初に表示されるページ
      autoPlay: true,//自動でスライドしてくれるか
      viewportFraction: 0.6,//各カードの表示される範囲の割合
      enableInfiniteScroll: true,//最後のカードから最初のカードへの遷移
      autoPlayInterval: Duration(seconds: 1),//カードのインターバル
      autoPlayAnimationDuration: Duration(milliseconds: 800),//スライドが始まって終わるまでの時間
    ),
  ),
```

使用例
```dart

CarouselSlider(
    items: [
      Image.asset(
        "images/cat001.jpg",
        width: 100,
        height: 100,
      ),
      Image.asset(
        "images/cat002.jpg",
        width: 100,
        height: 100,
      ),
      Image.asset(
        "images/cat003.jpg",
        width: 100,
        height: 100,
      ),
    ],
    options: CarouselOptions(
      height: 300,//高さ
      initialPage: 0,//最初に表示されるページ
      autoPlay: true,//自動でスライドしてくれるか
      viewportFraction: 0.6,//各カードの表示される範囲の割合
      enableInfiniteScroll: true,//最後のカードから最初のカードへの遷移
      autoPlayInterval: Duration(seconds: 1),//カードのインターバル
      autoPlayAnimationDuration: Duration(milliseconds: 800),//スライドが始まって終わるまでの時間
    ),
  ),

```
