# **アイテムとプレイヤーの当たり判定**

## **itemsprite.dart**


①ライブラリ追加  
②プログラム追加
③`CollisionCallbacks`ミックスイン
④当たり判定用オブジェクト追加

```dart
import 'dart:math';
import 'package:flame/components.dart';
//①ライブラリ追加
import 'package:flame/collisions.dart';
import 'game.dart';
//②プログラム追加
import 'mysprite.dart';

//③`CollisionCallbacks`ミックスイン
class ItemSprite extends SpriteComponent with HasGameRef<MainGame>, CollisionCallbacks {
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

    //④当たり判定用オブジェクト追加
    await add(CircleHitbox(radius: 20));

    await super.onLoad();
  }


//省略

```


⑤プレーヤーに当たったら消す

```dart

@override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

```

【ソースコード】

```dart

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'game.dart';
import 'mysprite.dart';

//アイテムの動きを作るクラス
//---------------------------------------------------------------
class ItemSprite extends SpriteComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
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

    await add(CircleHitbox(radius: 20));

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

  @override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}


```