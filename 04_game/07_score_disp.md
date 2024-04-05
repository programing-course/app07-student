# **スコア表示**

オブジェクトとクラスのまとめ
![score](img/07_score1-1.png)

スコアー表示は`score.dart`にまとめて作成  

<br><br>

![score](img/07_score1-2.png)

<br><br>

## **変数作成・クラス作成**

**game.dart**

①プログラム追加  
②HPテキスト表示  
③TPテキスト表示  
④HPテキスト描画  
⑤TPテキスト描画


```dart
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

import 'mysprite.dart';
import 'itemsprite.dart';
import 'tekisprite.dart';

//①プログラム追加
import 'score.dart';

//ゲーム全体の動きを作る（メインのクラス）
class MainGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {

  int HP = 100;
  int TP = 0;


  @override
  // --- 初期化 ---
  Future<void> onLoad() async {
    await super.onLoad();

    // スクリーンに線を引く
    await add(RectangleComponent(
      position: Vector2(0, size.y - 200),
      size: Vector2(size.x, 1),
    ));

    // スクリーンの情報取得
    await add(ScreenHitbox());

    // プレイヤー描画
    MySpriteRemove();

    //アイテムスプライト追加
    ItemSpriteRemove();

    //敵スプライト追加
    TekiSpriteRemove();

    //②HPテキスト表示
    HpTextRemove();

    //③TPテキスト表示
    TpTextRemove();
  }

  // プレイヤー描画(mysprit.dartのMySpriteクラスを呼び出す)
  Future<void> MySpriteRemove() async {
    await add(MySprite());
  }

  // アイテム描画
  Future<void> ItemSpriteRemove() async {
    await add(ItemSprite());
  }

  // 敵描画
  Future<void> TekiSpriteRemove() async {
    print("TekiSpriteRemove");
    await add(TekiSprite());
  }

  //④HPテキスト描画
  Future<void> HpTextRemove() async {
    //見出し
    await add(Hptext());
    //スコアー表示
    await add(Hpscore());
  }

  //⑤TPテキスト描画
  Future<void> TpTextRemove() async {
    //見出し
    await add(Tptext());
    //スコアー表示
    await add(Tpscore());
  }
}

```

**score.dart**

①HP見出し表示  
②HPスコア表示  
③TP見出し表示
④TPスコア表示

```dart

import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'game.dart';

// HPの見出し表示
class Hptext extends TextComponent with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    position = Vector2(50, gameRef.size.y - (size.y + 30) * 1.5);
    text = "HP";

    //スタイルをつける
    textRenderer = TextPaint(
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white));
  }

  //描画
  @override
  Future<void> render(Canvas canvas) async {
    super.render(canvas);
  }
}

// HPのスコア表示
class Hpscore extends TextComponent with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    position = Vector2(350, gameRef.size.y - (size.y + 30) * 1.5);
    text = "${gameRef.HP}/100";

    textRenderer = TextPaint(
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white));
  }

  @override
  Future<void> render(Canvas canvas) async {
    super.render(canvas);
  }
}

// TPの表示
class Tptext extends TextComponent with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    position = Vector2(50, gameRef.size.y - (size.y + 30));
    text = "TP";

    textRenderer = TextPaint(
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white));
  }

  @override
  Future<void> render(Canvas canvas) async {
    super.render(canvas);
  }
}

// TPのスコア表示
class Tpscore extends TextComponent with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    position = Vector2(350, gameRef.size.y - (size.y + 30));
    text = "${gameRef.TP}/100";

    textRenderer = TextPaint(
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white));
  }

  @override
  Future<void> render(Canvas canvas) async {
    super.render(canvas);
  }
}

```

## **スコア更新**

**itemsprite.dart**

①TPをポイント追加    

```dart

@override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      // 100までポイント追加
      if (gameRef.TP < 100) {
        gameRef.TP += 5;
        removeFromParent();
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

```

②TP再描画

```dart

@override
  Future<void> onRemove() async {
    await gameRef.ItemSpriteRemove();
    //②TP再描画
    await gameRef.TpTextRemove();
    super.onRemove();
  }

```

![score](img/07_score1-3.png)

## **再描画の前に元のオブジェクトを消す**

**game.dart**

```dart

//HPテキスト描画
  Future<void> HpTextRemove() async {
    await add(Hptext());

    //オブジェクトを消す（Hpscoreクラスで作られたオブジェクトを全て消す）
    children.whereType<Hpscore>().forEach((text) {
      text.removeFromParent();
    });
    await add(Hpscore());
  }

  //TPテキスト描画
  Future<void> TpTextRemove() async {
    await add(Tptext());

    //オブジェクトを消す（Tpscoreクラスで作られたオブジェクトを全て消す）
    children.whereType<Tpscore>().forEach((text) {
      text.removeFromParent();
    });
    await add(Tpscore());
  }

```

**tekiprite.dart**

①HPをマイナス

```dart

@override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      //①HPをマイナス
      if (gameRef.HP > 0) {
        gameRef.HP -= 30;
        removeFromParent();
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

```

②HP再描画

```dart

@override
  Future<void> onRemove() async {
    await gameRef.TekiSpriteRemove();
    //②HP再描画
    await gameRef.HpTextRemove();

    super.onRemove();
  }

```
