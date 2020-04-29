class Ship {
  
  PVector position;
  AnimatedSprite sprite;
  ShipState state;
  
  BouncingNumber idleAnimation = new BouncingNumber(-2, 2, 0);
  
  Ship(PVector position, AnimatedSprite sprite) {
    this.position = position;
    this.sprite = sprite;
    state = ShipState.IDLE;
  }

  void show() {
    sprite.show(position.x, position.y);
  }
  
  void update() {
    if (state == ShipState.IDLE) {
      position.y += idleAnimation.get();
    }
  }
}
