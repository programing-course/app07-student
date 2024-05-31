# **01_widgetの基本**

## **widgetを追加してみよう**

Widget（ウェジット）はFlutterのUIを構築しているパーツです。  
様々なWidgetを組み合わせることで複雑なUIを構築します。

<br>

※UI「User Interface（ユーザーインターフェイス）」・・・ユーザーとコンピューターの間で情報をやり取りするさまざまな機器や入力装置を指します。  
アプリのUIは、ボタン、入力フォーム、画像や文字、デザインなど画面に表示されるもの全般になります。

<br><br>

## **最初におさえておこう！**

- グループは「Container」
- 親子関係は「child:」
- 縦に並べるには「Column children」
- 横に並べるには「Row children」
- 間の余白は「SizedBox」
- 横幅・高さを指定できるのは「Container」「SizedBox」

<br>

## **`html/cssとwidgetの比較`**
コードの書き方はこれからの演習でやっていきます。まずはHTML/CSSとの違いをみてみましょう。

<br><br>
### **①「Container」（レイアウト/グループを作るwidget）**  

HTMLでグループを作るタグには`<header><nav><main><footer><div>`などがありました。  
flutterでは`Container`widgetを使ってグループを作ります。

****

![base](img/01_base1-1.png)

<br><br>

### **②「child:」widgetの中にwidgetを入れる（親子関係）**

widgetの中にwidgetを入れる場合は、中に入れる子のwidgetの前に`child:`をつけます。

![base](img/01_base1-2.png)

<br><br>

### **③「Column」widgetを縦に並べる**

HTMLではタグを順番に書くだけで縦に配置できました。  
flutterでは`Column` widgetで囲う必要があります。

![base](img/01_base1-3.png)

<br><br>

### **④「Row」widgetを横に並べる**

HTMLではCSSで「display:flex;」や「display:grid;」を使いました。  
flutterでは`Row` widgetを使います。

![base](img/01_base1-4.png)

<br><br>

### **⑤「SizedBox」widgetとwidgetに余白を入れる** 

CSSの`margin`のような役割をしてくれるwidgetです

![base](img/01_base1-5.png)
![base](img/01_base1-6.png)

<br><br>

### **⑥「width」幅、「height」高さの指定（指定できるwidgetは限られている！）**

HTML/CSSではタグやクラス名を指定して幅・高さをつけることができました。  
flutterでは指定できるwidgetが限られています。  
例えば`Column`で縦に並べたwidgetに横幅・高さを指定したい場合、`Column`に直接指定することはできません。  

<br><br>

![base](img/01_base1-7.png)

<br><br>

### **⑦widgetプロパティーまとめ**

これからの演習でよく使うWidgetプロパティ（状態・属性）をまとめています。  
「Column」「Row」のように`幅の指定やスタイルの指定ができないwidgetは「Container」で囲う`と覚えておきましょう。  
詳しい書き方はこれからの演習で勉強していきます。  

<br><br>

![base](img/01_base1-8.png)

<br><br>
