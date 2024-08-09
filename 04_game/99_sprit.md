```dart

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'game.dart';
import 'package:flutter/services.dart';

// プレイヤーの動きを作るクラス（SpriteComponent）
// キーボードイベント処理追加（KeyboardHandlerをミックスイン）
class MySprite extends SpriteComponent
    with HasGameRef<MainGame>, KeyboardHandler, CollisionCallbacks {
  late Vector2 _delta; // キーボード押した時の移動量
  double _speed = 500;

  // 各方向のスプライト
  late Sprite leftSprite;
  late Sprite rightSprite;
  late Sprite upSprite;
  late Sprite downSprite;

  @override
  Future<void> onLoad() async {
    // 各方向のスプライトを読み込む
    leftSprite = await _loadSprite('heart.png');
    rightSprite = await _loadSprite('heart2.png');
    upSprite = await _loadSprite('heart3.png');
    downSprite = await _loadSprite('heart4.png');

    // 初期状態のスプライトを設定
    sprite = downSprite;

    position = Vector2(gameRef.size.x * 0.5, gameRef.size.y * 0.5);
    size = Vector2(100, 100);
    anchor = Anchor.center;
    _delta = Vector2.zero();

    await add(CircleHitbox(radius: 40));

    await super.onLoad();
  }

  // スプライトの読み込み
  Future<Sprite> _loadSprite(String fileName) async {
    return await gameRef.loadSprite(fileName);
  }

  // キーボード操作
  @override
  bool onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyUpEvent) {
      _delta = Vector2.zero();
    } else if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
        _delta.x = -1;
        sprite = leftSprite; // 左向きのスプライトに変更
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
        _delta.x = 1;
        sprite = rightSprite; // 右向きのスプライトに変更
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
        _delta.y = -1;
        sprite = upSprite; // 上向きのスプライトに変更
      }
      if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
        _delta.y = 1;
        sprite = downSprite; // 下向きのスプライトに変更
      }
    }
    return true;
  }

  // スプライトの更新
  @override
  void update(double delta) {
    super.update(delta);

    position += _delta * delta * _speed;

    // ゲーム画面の端を超えないようにする処理
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


```dart

bool hasDisplayedNewSprite = false;

```

```dart

void onPlayerReachTargetPosition(Vector2 position) {
    // (300, 300)の位置で新しいスプライトを表示
    var targetPosition = Vector2(300, 300);

    if (position.distanceTo(targetPosition) < 10 && !hasDisplayedNewSprite) {
      // 新しいスプライトを表示
      add(NewSprite(position: targetPosition));
      hasDisplayedNewSprite = true;
    }
  }
```