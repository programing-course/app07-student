# **ソースコード**

## **main.dart**

```dart

// flutter_flameを使う
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
// ゲーム起動
import 'game.dart';

void main() => runApp(MyApp());

// アプリ起動
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xff2196f3),
        canvasColor: const Color(0xfffafafa),
      ),
      home: MyHomePage(),
    );
  }
}

// ゲーム画面起動
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GAME'),
        ),
        body: GameWidget(game: MainGame()));
  }
}


```

## **game.dart**

```dart

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/components.dart';

import 'mysprite.dart';
import 'itemsprite.dart';
import 'tekisprite.dart';
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

    //HPテキスト表示
    HpTextRemove();

    //TPテキスト表示ad
    TpTextRemove();

    // ボタン表示
    ButtonRemove();
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

  //HPテキスト描画
  Future<void> HpTextRemove() async {
    await add(Hptext());

    children.whereType<Hpscore>().forEach((text) {
      text.removeFromParent();
    });
    await add(Hpscore());

    children.whereType<HpBar>().forEach((text) {
      text.removeFromParent();
    });
    await add(HpBar());
  }

  //TPテキスト描画
  Future<void> TpTextRemove() async {
    await add(Tptext());

    children.whereType<Tpscore>().forEach((text) {
      text.removeFromParent();
    });
    await add(Tpscore());

    children.whereType<TpBar>().forEach((text) {
      text.removeFromParent();
    });
    await add(TpBar());
  }

  // ボタン追加
  Future<void> ButtonRemove() async {
    if (TP >= 20) {
      await add(Healbutton());
    } else {
      children.whereType<Healbutton>().forEach((text) {
        text.removeFromParent();
      });
    }
    if (TP >= 30) {
      await add(Attackbutton());
    } else {
      children.whereType<Attackbutton>().forEach((text) {
        text.removeFromParent();
      });
    }
  }

  // 敵を消す
  Future<void> TekiRemoveOnly() async {
    children.whereType<TekiSprite>().forEach((text) {
      text.removeFromParent();
    });
  }

  // ゲームオーバー
  Future<void> GameContol() async {
    await add(Gameovershori());
    await AllRemove();
  }

  // 全てのスプライトを消す
  Future<void> AllRemove() async {
    children.whereType<MySprite>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<TekiSprite>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<ItemSprite>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<Hpscore>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<HpBar>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<Tpscore>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<TpBar>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<Healbutton>().forEach((text) {
      text.removeFromParent();
    });
    children.whereType<Attackbutton>().forEach((text) {
      text.removeFromParent();
    });
  }

  // 変数初期化
  Future<void> Initialize() async {
    HP = 100;
    TP = 0;

    children.whereType<Gameovershori>().forEach((button) {
      button.removeFromParent();
    });
  }
}


```

## **mysprite.dart**

```dart

import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';
import 'game.dart';

//プレイヤーの動きを作るクラス（SpriteComponent）
//---------------------------------------------------------------
//キーボードイベント処理追加（KeyboardHandlerをミックスイン）
class MySprite extends SpriteComponent
    with HasGameRef<MainGame>, KeyboardHandler, CollisionCallbacks {
  late Vector2 _delta; //キーボード押した時の移動量
  double _speed = 500;

  @override
  Future<void> onLoad() async {
    //画像取得（描画の場所とサイズ指定）
    sprite = await Sprite.load('heart.png');
    position = Vector2(gameRef.size.x * 0.5, gameRef.size.y * 0.5);
    size = Vector2(100, 100);
    anchor = Anchor.center;
    _delta = Vector2.zero();

    await add(CircleHitbox(radius: 40));

    await super.onLoad();
  }

  //キーボード操作
  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is RawKeyUpEvent) {
      _delta = Vector2.zero();
    }
    if (event.character == 'a') {
      _delta.x = -1;
    }
    if (event.character == 'd') {
      _delta.x = 1;
    }
    if (event.character == 'w') {
      _delta.y = -1;
    }
    if (event.character == 's') {
      _delta.y = 1;
    }
    return true;
  }

  //スプライトの更新
  @override
  void update(double delta) {
    super.update(delta);

    position += _delta * delta * _speed;

    if (position.x < size.x / 2) {
      position.x = size.x / 2;
    }
    if (position.x > gameRef.size.x - size.x / 2) {
      position.x = gameRef.size.x - size.x / 2;
    }
    if (position.y < size.y / 2) {
      position.y = size.y / 2;
    }
    if (position.y > gameRef.size.y - size.y / 2 - 200) {
      position.y = gameRef.size.y - size.y / 2 - 200;
    }
  }
}


```

## **itemsprite.dart**

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
    if (gameRef.HP > 0) {
      await gameRef.ItemSpriteRemove();
      await gameRef.TpTextRemove();
      await gameRef.ButtonRemove();
    }
    super.onRemove();
  }

  @override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      if (gameRef.TP < 100) {
        gameRef.TP += 5;
        removeFromParent();
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }
}



```

## **tekisprite.dart**

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
    final pos_x = Random().nextDouble() * gameRef.size.x + 50;
    final pos_y = Random().nextDouble() * (gameRef.size.y - 300) + 50;

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
    if (gameRef.HP <= 0) {
      await gameRef.GameContol();
    } else {
      await gameRef.TekiSpriteRemove();
      await gameRef.HpTextRemove();
      await gameRef.ButtonRemove();
    }

    super.onRemove();
  }

  @override
  void onCollisionStart(
    // メソッド追加
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is MySprite) {
      if (gameRef.HP > 0) {
        gameRef.HP -= 30;
        removeFromParent();
      }
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

## **score.dart**

```dart

import 'package:flame/events.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'game.dart';

// HPの見出し表示
class Hptext extends TextComponent with HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    position = Vector2(50, gameRef.size.y - (size.y + 30) * 1.5);
    text = "HP";

    textRenderer = TextPaint(
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white));
  }

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

// HPバー表示
class HpBar extends RectangleComponent with HasGameRef<MainGame> {
  final barsize = 200.0;
  @override
  Future<void> onLoad() async {
    position = Vector2(100, gameRef.size.y - 60 * 1.5);
    size = Vector2((gameRef.HP * barsize / 100).toDouble(), 30);
    paint = Paint()..color = Colors.green;
  }

  void renderHpBarButton(Canvas canvas) {
    final rect = Rect.fromLTWH(
      0,
      0,
      barsize,
      30,
    );
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawRect(rect, bgPaint);
  }

  @override
  Future<void> render(Canvas canvas) async {
    renderHpBarButton(canvas);
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

// TPバー表示
class TpBar extends RectangleComponent with HasGameRef<MainGame> {
  final barsize = 200.0;
  @override
  Future<void> onLoad() async {
    position = Vector2(100, gameRef.size.y - 30 * 1.5);
    size = Vector2((gameRef.TP * barsize / 100).toDouble(), 30);
    paint = Paint()..color = Colors.blue;
  }

  void renderHpBarButton(Canvas canvas) {
    final rect = Rect.fromLTWH(
      0,
      0,
      barsize,
      30,
    );
    final bgPaint = Paint()..color = Colors.white;
    canvas.drawRect(rect, bgPaint);
  }

  @override
  Future<void> render(Canvas canvas) async {
    renderHpBarButton(canvas);
    super.render(canvas);
  }
}

// healボタン
class Healbutton extends TextBoxComponent
    with HasGameRef<MainGame>, TapCallbacks, KeyboardHandler {
  @override
  Future<void> onLoad() async {
    position = Vector2(50, gameRef.size.y - 150);
    text = "heal(20)";
    size = Vector2(200, 50);
    align = Anchor.center;

    super.onLoad();
  }

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    children.whereType<Healbutton>().forEach((button) {
      button.removeFromParent();
    });
    gameRef.HP = 100;
    gameRef.TP -= 20;
    await gameRef.HpTextRemove();
    await gameRef.TpTextRemove();
    await gameRef.ButtonRemove();
    super.onTapDown(event);
  }

  //キーボード操作
  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event.character == 'q') {
      children.whereType<Healbutton>().forEach((button) {
        button.removeFromParent();
      });
      gameRef.HP = 100;
      gameRef.TP -= 20;
      gameRef.HpTextRemove();
      gameRef.TpTextRemove();
      gameRef.ButtonRemove();
    }
    return true;
  }

  void renderHealButton(Canvas canvas) {
    final rect = Rect.fromLTWH(
      0,
      0,
      200,
      50,
    );
    final bgPaint = Paint()..color = Colors.green;
    canvas.drawRect(rect, bgPaint);
  }

  @override
  Future<void> render(Canvas canvas) async {
    renderHealButton(canvas);
    super.render(canvas);
  }
}

class Attackbutton extends TextBoxComponent
    with HasGameRef<MainGame>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    position = Vector2(300, gameRef.size.y - 150);
    text = "attack(30)";
    size = Vector2(200, 50);
    align = Anchor.center;

    super.onLoad();
  }

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    children.whereType<Attackbutton>().forEach((button) {
      button.removeFromParent();
    });

    gameRef.TP -= 30;
    await gameRef.TpTextRemove();
    await gameRef.ButtonRemove();
    await gameRef.TekiRemoveOnly();

    super.onTapDown(event);
  }

//キーボード操作
  @override
  bool onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event.character == 'e') {
      children.whereType<Attackbutton>().forEach((button) {
        button.removeFromParent();
      });

      gameRef.TP -= 30;
      gameRef.TpTextRemove();
      gameRef.ButtonRemove();
      gameRef.TekiRemoveOnly();
    }
    return true;
  }

  @override
  Future<void> render(Canvas canvas) async {
    renderAttackButton(canvas);
    super.render(canvas);
  }

  void renderAttackButton(Canvas canvas) {
    final rect = Rect.fromLTWH(
      0,
      0,
      200,
      50,
    );
    final bgPaint = Paint()..color = Colors.red;
    canvas.drawRect(rect, bgPaint);
  }
}

class Gameovershori extends TextBoxComponent
    with TapCallbacks, HasGameRef<MainGame> {
  @override
  Future<void> onLoad() async {
    size = Vector2(220, 50);
    position = Vector2(
        gameRef.size.x / 2 - size.x / 2, gameRef.size.y / 2 - size.y / 2);
    text = "GAMEOVER";
    align = Anchor.center;

    super.onLoad();
  }

  @override
  Future<void> onTapDown(TapDownEvent event) async {
    children.whereType<Gameovershori>().forEach((button) {
      button.removeFromParent();
    });

    await gameRef.Initialize();
    await gameRef.MySpriteRemove();
    await gameRef.TekiSpriteRemove();
    await gameRef.ItemSpriteRemove();
    await gameRef.HpTextRemove();
    await gameRef.TpTextRemove();
    await gameRef.ButtonRemove();

    super.onTapDown(event);
  }

  @override
  Future<void> render(Canvas canvas) async {
    rendergemaoverButton(canvas);
    super.render(canvas);
  }

  void rendergemaoverButton(Canvas canvas) {
    final rect = Rect.fromLTWH(
      0,
      0,
      220,
      50,
    );
    final bgPaint = Paint()..color = Colors.red;
    canvas.drawRect(rect, bgPaint);
  }
}


```