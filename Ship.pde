class Ship {
  
  PVector position;
  AnimatedSprite sprite;
  ShipState state;
  Sprite idle;
  boolean shooting = false;
  
  float rotationAngle;
  float rotationFactor;

  BouncingNumber idleAnimation = new BouncingNumber(-2, 2, 0);
  
  Ship(PVector position) {
    this.position = position;
    this.sprite = new AnimatedSprite("enemy", 8, 0.25, 12);
    idle = new Sprite("enemy_idle.png", 0.25);
    state = ShipState.IDLE;
  }

  void show() {
    if (state == ShipState.IDLE) {
      sprite.show(position.x, position.y);
    } else if (state == ShipState.PREPARING_ATTACK) {
      pushMatrix();
      translate(position.x, position.y);
      float angle = MathUtil.angleLerp(0, rotationAngle, rotationFactor);
      rotate(angle);
      idle.show(0, 0);
      popMatrix();
    } else if (state == ShipState.ATTACKING) {
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotationAngle);
      idle.show(0, 0);
      popMatrix();
    }
  }
  
  void update() {
    if (state == ShipState.IDLE) {
      position.y += idleAnimation.get();
    } else if (state == ShipState.PREPARING_ATTACK) {
      if (rotationFactor >= 1) {
        state = ShipState.ATTACKING;
      } else {
        rotationFactor += 0.05;
      }
    } else if (state == ShipState.ATTACKING) {
      
    }
  }

  void attack(Planet planet) { 
    state = ShipState.PREPARING_ATTACK;
    
    float dx = planet.position.x - position.x;
    float dy = planet.position.y - position.y;
    rotationAngle = atan2(dy, dx) + HALF_PI;
    rotationFactor = 0;
  }
}
