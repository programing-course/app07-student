# **障害物の描画と当たり判定**

## **オブジェクトの制御**

![object1-1](img/07_object1-1.png)

**【game.dart】**

各ステージに表示するオブジェクトを

### **①オブジェクト表示用**

```dart

import 'setting.dart';
import 'object.dart';

```

```dart

// オブジェクトの描画
  Future<void> objectRemove() async {
    switch (currentScene) {
      case 1:
        //① オブジェクト（三角形用）関数呼び出し
        //色と頂点の位置を指定
        await triangleRemove(
            Color.fromARGB(255, 211, 46, 46), //色
            screenSize.x / 2,                 //頂点１のX
            Y_GROUND_POSITION - 50,           //頂点１のY
            screenSize.x / 2 - 50,            //頂点２のX
            Y_GROUND_POSITION,                //頂点２のY
            screenSize.x / 2 + 50,            //頂点３のX
            Y_GROUND_POSITION);               //頂点３のY
        break;
      default:
    }
  }

  // 三角形描画用
  // 引数
  // 色、３つの頂点（x,y）
  Future<void> triangleRemove(
      color, pos1_x, pos1_y, pos2_x, pos2_y, pos3_x, pos3_y) async {
    triangle Component =
        triangle(color, pos1_x, pos1_y, pos2_x, pos2_y, pos3_x, pos3_y);
    await add(Component);
  }


```

**【object.dart】**

### **②オブジェクト表示用のdartを作成**

```dart

import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'game.dart';

class triangle extends RectangleComponent
    with HasGameRef<MainGame>, CollisionCallbacks {

  //データ受け取り
  triangle(this.color, this.pos1_x, this.pos1_y, this.pos2_x, this.pos2_y,
      this.pos3_x, this.pos3_y);

  var color;
  double pos1_x;
  double pos1_y;
  double pos2_x;
  double pos2_y;
  double pos3_x;
  double pos3_y;

  @override
  Future<void> onLoad() async {
    paint = Paint()..color = color;

    anchor = Anchor.topCenter;

    //当たり判定用のHitbox
    add(PolygonHitbox([
      Vector2(pos1_x, pos1_y),
      Vector2(pos2_x, pos2_y),
      Vector2(pos3_x, pos3_y),
    ])
      ..collisionType = CollisionType.passive);
  }

  @override
  Future<void> render(Canvas canvas) async {
    super.render(canvas);

    //頂点の座標を指定して描画
    final path = Path();
    path.moveTo(pos1_x, pos1_y); // 頂点
    path.lineTo(pos2_x, pos2_y); // 左下
    path.lineTo(pos3_x, pos3_y); // 右下
    path.close(); // 閉じる

    // パスをキャンバスに描画
    canvas.drawPath(path, paint);
  }
}

```

**【player.dart】**

### **③オブジェクト呼び出し**

```dart

@override
  Future<void> onRemove() async {
    await gameRef.PlayerRemove();
    await gameRef.TextRemove();
    //③オブジェクト呼び出し
    await gameRef.objectRemove();

    super.onRemove();
  }

```

## **練習：位置を変えて表示**

**【game.dart】**

```dart

Future<void> objectRemove() async {
    switch (currentScene) {
      case 1:
        await triangleRemove(
            Color.fromARGB(255, 211, 46, 46),
            screenSize.x / 2,
            Y_GROUND_POSITION - 50,
            screenSize.x / 2 - 50,
            Y_GROUND_POSITION,
            screenSize.x / 2 + 50,
            Y_GROUND_POSITION);
        //追加
        await triangleRemove(
            Color.fromARGB(255, 211, 203, 46),
            screenSize.x / 4,
            Y_GROUND_POSITION - 100,
            screenSize.x / 4 - 50,
            Y_GROUND_POSITION,
            screenSize.x / 4 + 50,
            Y_GROUND_POSITION);
        break;
      default:
    }
  }

```

![object1-1](img/07_object1-2.png)


## **当たり判定**

**【player.dart】**

### **④障害物に当たったら負け**

```dart

import 'object.dart';

```

```dart

@override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    //④triangleと衝突
    if (other is triangle) {
      // 中間地点まで戻る(中間地点未到達の場合は０なのでスタートに戻る)
      currentScene = RetryStage;
      removeFromParent();
    }

    super.onCollisionStart(intersectionPoints, other);
  }

```

![object1-1](img/07_object1-3.png)

**【game.dart】**

### **⑤クリアしてから表示**

```dart

Future<void> objectRemove() async {
    //⑤オブジェクト削除
    children.whereType<triangle>().forEach((text) {
      text.removeFromParent();
    });
    
    switch (currentScene) {
      case 1:
        await triangleRemove(
            Color.fromARGB(255, 211, 46, 46),
            screenSize.x / 2,
            Y_GROUND_POSITION - 50,
            screenSize.x / 2 - 50,
            Y_GROUND_POSITION,
            screenSize.x / 2 + 50,
            Y_GROUND_POSITION);
      //省略
    }            
```