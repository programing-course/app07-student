# **プレーヤーのアニメーション**

## **進む方向によって描画を変える**

**【player.dart】**

### **①コンポーネントの変更**

SpriteComponent→SpriteAnimationComponentに変更

```dart

class Player extends SpriteAnimationComponent
    with HasGameRef<MainGame>, KeyboardHandler, CollisionCallbacks {

//省略

    }

```

**【player.dart】**

### **②変数宣言**
### **③スプライトロード**

```dart

bool isCollidedScreenHitboxX = false;
  bool isCollidedScreenHitboxY = false;
  Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200; // 移動速度
  final double jumpForce = 400; // ジャンプ力
  final double gravity = 800; // 重力の量
  bool isOnGround = false; // 地面にいるかの判定
  bool isInHole = false;
  double hole_X = 0.0;

  // ②各方向のスプライト
  late SpriteAnimation leftAnimation;
  late SpriteAnimation rightAnimation;
  late SpriteAnimation upAnimation;
  late SpriteAnimation downAnimation;
  late SpriteAnimation stop_leftAnimation;
  late SpriteAnimation stop_rightAnimation;
  late SpriteAnimation stop_upAnimation;
  late SpriteAnimation stop_downAnimation;

  // ②方向フラグ
  bool leftflg = false;
  bool upflg = false;
  bool downflg = false;
  bool rightflg = false;

  @override
  Future<void> onLoad() async {
    //③スプライトロード
    final rightSprites = [
      await gameRef.loadSprite('ika2.png'),
    ];
    final downSprites = [
      await gameRef.loadSprite('ika2.png'),
    ];
    final upSprites = [
      await gameRef.loadSprite('ika2.png'),
    ];
    final leftSprites = [
      await gameRef.loadSprite('ika.png'),
    ];
    final stop_rightSprites = [
      await gameRef.loadSprite('ika2.png'),
      await gameRef.loadSprite('ika2_up.png'),
    ];
    final stop_downSprites = [
      await gameRef.loadSprite('ika2.png'),
      await gameRef.loadSprite('ika2_up.png'),
    ];
    final stop_upSprites = [
      await gameRef.loadSprite('ika2.png'),
      await gameRef.loadSprite('ika2_up.png'),
    ];
    final stop_leftSprites = [
      await gameRef.loadSprite('ika.png'),
      await gameRef.loadSprite('ika_up.png'),
    ];

    // ③アニメーション（画像切り替え）
    rightAnimation = SpriteAnimation.spriteList(rightSprites, stepTime: 0.2);
    downAnimation = SpriteAnimation.spriteList(downSprites, stepTime: 0.2);
    upAnimation = SpriteAnimation.spriteList(upSprites, stepTime: 0.2);
    leftAnimation = SpriteAnimation.spriteList(leftSprites, stepTime: 0.2);
    stop_rightAnimation =
        SpriteAnimation.spriteList(stop_rightSprites, stepTime: 0.2);
    stop_downAnimation =
        SpriteAnimation.spriteList(stop_downSprites, stepTime: 0.2);
    stop_upAnimation =
        SpriteAnimation.spriteList(stop_upSprites, stepTime: 0.2);
    stop_leftAnimation =
        SpriteAnimation.spriteList(stop_leftSprites, stepTime: 0.2);

    animation = stop_downAnimation;

    //③コメントアウト
    // sprite = await Sprite.load('ika2.png');
    size = Vector2(PLAYER_SIZE_X, PLAYER_SIZE_Y);
    position = Vector2(size.x / 2, Y_GROUND_POSITION - size.y / 2);
    anchor = Anchor.center;
    priority = 10;
    add(RectangleHitbox()); //①当たり判定用
    await super.onLoad();
  }

  //省略

```

**【player.dart】**

### **④キーボード操作（アニメーションの切り替え）**

```dart

@override
  bool onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        //④どちらを向いているか
        leftflg = true;
        upflg = false;
        downflg = false;
        rightflg = false;
        moveLeft();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        //④どちらを向いているか
        leftflg = false;
        upflg = false;
        downflg = false;
        rightflg = true;
        moveRight();
      } else if (keysPressed.contains(LogicalKeyboardKey.space)) {
        //④どちらを向いているか
        leftflg = false;
        upflg = false;
        downflg = false;
        rightflg = false;
        jump();
      }
    } else if (event is KeyUpEvent) {
      stopMovement();
    }
    return true;
  }

  // 左移動
  void moveLeft() {
    velocity.x = -moveSpeed;
    //④アニメーション切り替え
    if (animation != leftAnimation) {
      animation = leftAnimation;
    }
  }

  // 右移動
  void moveRight() {
    velocity.x = moveSpeed;
    //④アニメーション切り替え
    if (animation != rightAnimation) {
      animation = rightAnimation;
    }
  }

  // ストップ
  void stopMovement() {
    velocity.x = 0;
    //④左向きのアニメーション
    if (leftflg) {
      animation = stop_leftAnimation;
    }
    //④上向きのアニメーション
    if (upflg) {
      animation = stop_upAnimation;
    }
    //④右向きのアニメーション
    if (rightflg) {
      animation = stop_rightAnimation;
    }
    //④下向きのアニメーション
    if (downflg) {
      animation = stop_downAnimation;
    }
  }

```
