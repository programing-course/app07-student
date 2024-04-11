# **ゲームオーバー表示**

**tekisprit.dart**

①HPが０以下でゲームオーバー表示  

```dart

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

```

**game.dart**

```dart

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
```

**score.dart**

```dart

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

    //全て初期化
    await gameRef.Initialize();　//変数初期化　game.dartに追加
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
