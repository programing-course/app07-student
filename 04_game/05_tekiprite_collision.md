# **敵の表示**

## **geme.dart**

### **敵のクラスを呼び出す**

①敵の描画  
②敵のプログラム追加

```dart
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

import 'mysprite.dart';
import 'itemsprite.dart';
//②敵のプログラム追加
import 'tekisprite.dart'

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

    //アイテムスプライト追加
    ItemSpriteRemove();

    //②敵スプライト追加
    TekiSpriteRemove();
  }

  // プレイヤー描画(mysprit.dartのMySpriteクラスを呼び出す)
  Future<void> MySpriteRemove() async {
    await add(MySprite());
  }

  //アイテム描画
  Future<void> ItemSpriteRemove() async {
    await add(ItemSprite());
  }

  //①敵描画
  Future<void> TekiSpriteRemove() async {
    print("TekiSpriteRemove");
    await add(TekiSprite());
  }
}


```

## **敵を表示・動かす**

**tekisprite.dart**

①mathライブラリ追加  
②角度をつけて移動

```dart

//①角度計算する 
import 'dart:math';

import 'package:flame/components.dart';
import 'game.dart';

//敵の動きを作るクラス
//---------------------------------------------------------------
class TekiSprite extends SpriteComponent with HasGameRef<MainGame> {
  late Vector2 velocity; //移動量

  @override
  Future<void> onLoad() async {
    //②スピード
    const double TekiSpeed = 500;

    //②pi:円周率
    const double Rad = pi / 180;

    //②開始位置
    final pos_x = Random().nextDouble() * gameRef.size.x;
    final pos_y = Random().nextDouble() * (gameRef.size.y - 250);

    //②移動量
    //45*Rad:ラジアン(角度×π/180)
    //cos(ラジアン)：横方向
    //sin(ラジアン)：縦方向
    final vx = TekiSpeed * cos(45 * Rad);
    final vy = TekiSpeed * sin(45 * Rad);

    sprite = await Sprite.load('imo.png');
    //②変数使う
    position = Vector2(pos_x, pos_y);
    size = Vector2(50, 50);
    //②変数使う
    velocity = Vector2(vx, vy);
    anchor = Anchor.center;

    await super.onLoad();
  }

  //スプライトの更新
  @override
  void update(double delta) async {
    position += velocity * delta;

    super.update(delta);
  }
}


```

## **下線に当たったら跳ね返る**

`update`で条件追加  
下線に当たるまで再読み込みして確認しよう！

```dart

@override
void update(double delta) async {
  position += velocity * delta;
  //下線に当たった時  
  if (position.y > gameRef.size.y - 200 - size.y / 2) {
    velocity.y = -velocity.y;
  }
  super.update(delta);
}

```

<br><br>

## **オブジェクト同士の衝突**

`CollisionCallbacks`の追加により、`onCollisionStart` , `onCollision` , `onCollisionEnd`
というメソッドが利用可能  

<br>

**onCollisionStart**  

衝突の開始時  

**onCollision**  

衝突中  

**onCollisionEnd**  

衝突の終了時  

<br><br>

### **敵とプレイヤーの衝突**

**game.dart**  

①`HasCollisionDetection`をミックスイン

```dart

class MainGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override

  //省略

```

**mysprite.dart**  

②ライブラリ追加

```dart

import 'package:flutter/services.dart';
import 'package:flame/components.dart';
//②ライブラリ追加
import 'package:flame/collisions.dart';
import 'game.dart';

```

③`CollisionCallbacks`ミックスイン

```dart

class MySprite extends SpriteComponent
    with HasGameRef<MainGame>, KeyboardHandler, CollisionCallbacks {

    //省略

```

**tekisprite.dart**  

④ライブラリ追加  
⑤mysprite.dart追加  
⑥`CollisionCallbacks`をミックスイン

```dart

import 'dart:math';

import 'package:flame/components.dart';
//④衝突判定
import 'package:flame/collisions.dart';
import 'game.dart';
//⑤プログラム追加
import 'mysprite.dart';

//⑥CollisionCallbacksをミックスイン
class TekiSprite extends SpriteComponent
    with HasGameRef<MainGame>, CollisionCallbacks {


  late Vector2 velocity; //移動量

  //省略

```

⑦当たり判定用のオブジェクトを追加

**tekisprite.dart**  

```dart

@override
  Future<void> onLoad() async {
    //省略

    //⑦当たり判定用のオブジェクト追加
    await add(CircleHitbox(radius: 20));

    await super.onLoad();
  }

```

**mysprite.dart**

```dart

@override
  Future<void> onLoad() async {
    //省略

    //⑦当たり判定用のオブジェクト追加
    await add(CircleHitbox(radius: 40));

    await super.onLoad();
  }

```

![tekisprite](img/05_tekisprite1-1.png)


⑤onCollisionStart、onCollision、onCollisionEndを追加

```dart

//省略

@override
void update(double delta) async {
  position += velocity * delta;

  super.update(delta);
}

//⑤追加
@override
void onCollisionStart(
  Set<Vector2> intersectionPoints,
  PositionComponent other,
) {

  //MySpriteと衝突した時、敵を消す
  if (other is MySprite) {
    removeFromParent();
  }

  super.onCollisionStart(intersectionPoints, other);
}

@override
void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  super.onCollision(intersectionPoints, other);
}

@override
void onCollisionEnd(PositionComponent other) {
  super.onCollisionEnd(other);
} 

```

衝突している物体同士の交点が`intersectionPoints`で、衝突している相手を`other`で取得  


**敵再表示**

```dart

@override
  Future<void> onRemove() async {
    await gameRef.TekiSpriteRemove();

    super.onRemove();
  }


```

<br><br>


## **オブジェクト同士の衝突（上左右の壁）**

①反射したかどうか判定

```dart

class TekiSprite extends SpriteComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  late Vector2 velocity;
  
  //①反射したかどうか判定宣言
  bool isCollidedScreenHitboxX = false;
  bool isCollidedScreenHitboxY = false;

  //省略
```

②`onCollision`に壁と当たった時の処理を追加

```dart

@override
void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {

  //壁に当たったら
  if (other is ScreenHitbox) {
    final screenHitBoxRect = other.toAbsoluteRect();

    //当たった壁がどこなのか判定
    for (final point in intersectionPoints) {
      if (point.x == screenHitBoxRect.left && !isCollidedScreenHitboxX) {
        velocity.x = -velocity.x;
        isCollidedScreenHitboxX = true;
      }
      if (point.x == screenHitBoxRect.right && !isCollidedScreenHitboxX) {
        velocity.x = -velocity.x;
        isCollidedScreenHitboxX = true;
      }
      if (point.y == screenHitBoxRect.top && !isCollidedScreenHitboxY) {
        velocity.y = -velocity.y;
        isCollidedScreenHitboxY = true;
      }
      if (point.y == screenHitBoxRect.bottom && !isCollidedScreenHitboxY) {
        velocity.y = -velocity.y;
        isCollidedScreenHitboxY = true;
      }
    }
  }

  super.onCollision(intersectionPoints, other);
}

@override
void onCollisionEnd(PositionComponent other) {
  // 初期化
  isCollidedScreenHitboxX = false;
  isCollidedScreenHitboxY = false;
  super.onCollisionEnd(other);
}

```

## **角度をランダムにする**

①ライブラリ追加（lerpDouble用）  
②角度をランダムに`spawnAngle`関数呼び出し  
③角度の範囲指定関数追加

```dart

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
//①追加
import 'dart:ui';

import 'game.dart';
import 'mysprite.dart';

```

```dart

@override
  Future<void> onLoad() async {
    const double TekiSpeed = 100;

    
    const double Rad = pi / 180;

    
    final pos_x = Random().nextDouble() * gameRef.size.x;
    final pos_y = Random().nextDouble() * (gameRef.size.y - 250);

    //②角度をランダムに`spawnAngle`関数に変更
    final vx = TekiSpeed * cos(spawnAngle * Rad);
    final vy = TekiSpeed * sin(spawnAngle * Rad);

    sprite = await Sprite.load('imo.png');
    position = Vector2(pos_x, pos_y);
    size = Vector2(50, 50);
    velocity = Vector2(vx, vy);
    anchor = Anchor.center;

    await add(CircleHitbox(radius: 20));

    await super.onLoad();
  }


  //③角度の範囲指定
  double get spawnAngle {
    const double TekiMinAngle = 45;
    const double TekiMaxAngle = 135;

    final random = Random().nextDouble();

    lerpDouble(a,b,t)　→　return a + (b - a) * t;
    //45 + (135 - 45) * ランダム　 
    //lerpDoubleは、TekiMinAngleとTekiMaxAngleの2つの角度を、randomの比率で分ける角度を返す
    final spawnAngle = lerpDouble(TekiMinAngle, TekiMaxAngle, random)!;
    return spawnAngle;
  }

```


【ソースコード】

```dart

import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'dart:ui';

import 'game.dart';
import 'mysprite.dart';

//敵の動きを作るクラス
//---------------------------------------------------------------
class TekiSprite extends SpriteComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  late Vector2 velocity; //移動量

  bool isCollidedScreenHitboxX = false;
  bool isCollidedScreenHitboxY = false;

  @override
  Future<void> onLoad() async {
    const double TekiSpeed = 100;

    //pi:円周率
    const double Rad = pi / 180;

    //開始位置
    final pos_x = Random().nextDouble() * gameRef.size.x;
    final pos_y = Random().nextDouble() * (gameRef.size.y - 250);

    //移動量
    //45*Rad:ラジアン(角度×π/180)
    //cos(ラジアン)：横方向
    //sin(ラジアン)：縦方向
    final vx = TekiSpeed * cos(spawnAngle * Rad);
    final vy = TekiSpeed * sin(spawnAngle * Rad);

    sprite = await Sprite.load('imo.png');
    position = Vector2(pos_x, pos_y);
    size = Vector2(50, 50);
    velocity = Vector2(vx, vy);
    anchor = Anchor.center;

    await add(CircleHitbox(radius: 20));

    await super.onLoad();
  }

  //移動量の範囲指定
  double get spawnAngle {
    const double TekiMinAngle = 45;
    const double TekiMaxAngle = 135;

    final random = Random().nextDouble();

    //lerpDouble(a,b,t)　→　return a + (b - a) * t;
    //45 + (135 - 45) * ランダム
    //lerpDoubleは、TekiMinAngleとTekiMaxAngleの2つの角度を、randomの比率で分ける角度を返す
    final spawnAngle = lerpDouble(TekiMinAngle, TekiMaxAngle, random)!;
    return spawnAngle;
  }

  //スプライトの更新
  @override
  void update(double delta) async {
    position += velocity * delta;

    //下線に当たった時
    if (position.y > gameRef.size.y - 200 - size.y / 2) {
      velocity.y = -velocity.y;
    }
    super.update(delta);
  }

  @override
  Future<void> onRemove() async {
    await gameRef.TekiSpriteRemove();

    super.onRemove();
  }

  @override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      print("当たった");
      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    //壁に当たったら
    if (other is ScreenHitbox) {
      final screenHitBoxRect = other.toAbsoluteRect();

      //当たった壁がどこなのか判定
      for (final point in intersectionPoints) {
        if (point.x == screenHitBoxRect.left && !isCollidedScreenHitboxX) {
          velocity.x = -velocity.x;
          isCollidedScreenHitboxX = true;
        }
        if (point.x == screenHitBoxRect.right && !isCollidedScreenHitboxX) {
          velocity.x = -velocity.x;
          isCollidedScreenHitboxX = true;
        }
        if (point.y == screenHitBoxRect.top && !isCollidedScreenHitboxY) {
          velocity.y = -velocity.y;
          isCollidedScreenHitboxY = true;
        }
        if (point.y == screenHitBoxRect.bottom && !isCollidedScreenHitboxY) {
          velocity.y = -velocity.y;
          isCollidedScreenHitboxY = true;
        }
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    isCollidedScreenHitboxX = false;
    isCollidedScreenHitboxY = false;

    super.onCollisionEnd(other);
  }
}

```
