class Ship {
  
  PVector position;
  AnimatedSprite sprite;
  ShipState state;
  Sprite idle;
  boolean shooting = false;
  
  Planet attackingPlanet;
  float rotationAngle;
  float rotationFactor;
  PImage bulletImage;
  Bullet bullet;

  BouncingNumber idleAnimation = new BouncingNumber(-2, 2, 0);
  
  Ship(PVector position, PImage bulletImage) {
    this.position = position;
    this.sprite = new AnimatedSprite(AnimatedSpriteResource.ENEMY, 0.25, 12);
    this.bulletImage = bulletImage;
    idle = new Sprite("enemy_idle.png", 0.25);
    state = ShipState.IDLE;
  }

  void show() {
    if (state == ShipState.IDLE) {
      sprite.show(position.x, position.y);
    } else if (state == ShipState.PREPARING_ATTACK || state == ShipState.STOP_ATTACKING) {
      pushMatrix();
      translate(position.x, position.y);
      float angle = lerp(0, rotationAngle, rotationFactor);
      rotate(angle);
      idle.show(0, 0);
      popMatrix();
    } else if (state == ShipState.ATTACKING) {
      bullet.show();
      
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
        SoundResource.SHOOT.get().play();
        bullet = new Bullet(bulletImage, 0.1, position.copy(), rotationAngle, attackingPlanet.position, new Runnable() {
          @Override
          public void run() {
            attackingPlanet.explode();
            state = ShipState.STOP_ATTACKING;
          }
        });
      } else {
        rotationFactor += 0.05;
      }
    } else if (state == ShipState.ATTACKING) {
      bullet.update();
    } else if (state == ShipState.STOP_ATTACKING) {
      if (rotationFactor > 0) {
        rotationFactor -= 0.05;        
      } else {
        state = ShipState.IDLE;
      }
    }
  }

  void attack(Planet planet) { 
    state = ShipState.PREPARING_ATTACK;
    
    float dx = planet.position.x - position.x;
    float dy = planet.position.y - position.y;
    rotationAngle = atan2(dy, dx) + HALF_PI;
    rotationFactor = 0;
    attackingPlanet = planet;
  }
}
