# **アイテムの表示**

## **geme.dart**

### **アイテムのクラスを呼び出す**

①アイテム描画  
②アイテムのプログラム追加

```dart
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

import 'mysprite.dart';
//②アイテムのプログラム追加
import 'itemsprite.dart';

//ゲーム全体の動きを作る（メインのクラス）
class MainGame extends FlameGame with HasKeyboardHandlerComponents {
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

    //①アイテムスプライト追加
    ItemSpriteRemove();
  }

  // プレイヤー描画(mysprit.dartのMySpriteクラスを呼び出す)
  Future<void> MySpriteRemove() async {
    await add(MySprite());
  }

  //①アイテム描画
  Future<void> ItemSpriteRemove() async {
    await add(ItemSprite());
  }
}


```

## **itemsprite.dart**

①スプライトの表示

```dart

import 'package:flame/components.dart';
import 'game.dart';

//アイテムの動きを作るクラス
//---------------------------------------------------------------
class ItemSprite extends SpriteComponent with HasGameRef<MainGame> {
  //移動スピード
  var _speed = 200.0;

  @override
  Future<void> onLoad() async {
    //画像取得（描画の場所とサイズ指定）
    sprite = await Sprite.load('ika.png');
    position = Vector2(100, 100);
    size = Vector2(50, 50);
    anchor = Anchor.center;

    await super.onLoad();
  }

  //スプライトの更新
  @override
  void update(double delta) async {
    // 縦方向のみ移動
    position.y += _speed * delta;

    super.update(delta);
  }
}


```

## **アイテムを消す**

**itemsprite.dart**

下線まで来たらアイテムを消す

**removeFromParent**  
addしたデータを削除する

```dart

@override
void update(double delta) async {
  if (position.y > gameRef.size.y - 200 - size.y / 2) {
    removeFromParent();
  } else {
    position.y += _speed * delta;
  }

  super.update(delta);
}

```

## **アイテムを再表示**

`removeFromParent()`が実行されたあと`onRemove()`関数が実行される  

`game.dart`の`ItemSpriteRemove()`を実行することで、再度、`ItemSprite`クラスが`add`されてオブジェクトが描画される  

```dart

@override
  Future<void> onRemove() async {
    await gameRef.ItemSpriteRemove();
    super.onRemove();
  }

```

## **アイテムの表示位置をランダムにする**

**random関数を使うための準備**  

①mathパッケージインポート

```dart
import 'dart:math';
```

②ランダム関数取得  
Double型のRandom（0~1未満の数値）を取得し、画面の横サイズを掛ける

③スタート位置を指定  
yの位置もRandomで取得してよい

```dart

@override
Future<void> onLoad() async {

  //②ランダムな値を取得
  final pos_x = Random().nextDouble() * gameRef.size.x;

  //画像取得（描画の場所とサイズ指定）
  sprite = await Sprite.load('ika.png');

  //③スタート位置を指定
  position = Vector2(pos_x, -500);
  size = Vector2(50, 50);
  anchor = Anchor.center;

  await super.onLoad();
}

```

【ソースコード】

```dart

import 'dart:math';
import 'package:flame/components.dart';
import 'game.dart';

//アイテムの動きを作るクラス
//---------------------------------------------------------------
class ItemSprite extends SpriteComponent with HasGameRef<MainGame> {
  //移動スピード
  var _speed = 200.0;

  @override
  Future<void> onLoad() async {
    final pos_x = Random().nextDouble() * gameRef.size.x;

    //画像取得（描画の場所とサイズ指定）
    sprite = await Sprite.load('ika.png');
    position = Vector2(pos_x, -500);
    size = Vector2(50, 50);
    anchor = Anchor.center;

    await super.onLoad();
  }

  //スプライトの更新
  @override
  void update(double delta) async {
    if (position.y > gameRef.size.y - 200 - size.y / 2) {
      removeFromParent();
    } else {
      position.y += _speed * delta;
    }

    super.update(delta);
  }

  @override
  Future<void> onRemove() async {
    await gameRef.ItemSpriteRemove();
    super.onRemove();
  }
}

}

```