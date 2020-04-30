enum PlanetState {
  ALIVE,
  EXPLODING,
  DEAD
}

class Planet {
  PVector position;
  PImage image;
  boolean rotateClockwise;
  
  PlanetState state = PlanetState.ALIVE;
  
  private AnimatedSprite explosionSprite;
  
  Planet(PVector position, PImage image, boolean rotateClockwise) {
    this.position = position;
    this.image = image;
    this.rotateClockwise = rotateClockwise;
  }
  
  void show() {
    if (state == PlanetState.ALIVE) {
      showPlanet(255);
    } else if (state == PlanetState.EXPLODING) {
      if (explosionSprite.getFrameIndex() < explosionSprite.getFrameCount()) {
        float op = 255 - map(explosionSprite.getFrameIndex(), 0, explosionSprite.getFrameCount(), 0, 255);
        showPlanet(op);
        
        explosionSprite.show(position.x, position.y);
      } else {
        state = PlanetState.DEAD;
      }
    } else { // DEAD
      
    }
  }
  
  private void showPlanet(float opacity) {
    pushMatrix();
      
    translate(position.x, position.y);
    
    if (rotateClockwise) {
      rotate(radians(frameCount % (360 * 30)) / 30);
    } else {
      rotate(-radians(frameCount % (360 * 30)) / 30);
    }
    
    pushStyle();
    tint(255, opacity);
    image(image, -image.width / 2, -image.height / 2);
    popStyle();
    
    popMatrix();
  }
  
  void explode() {
    state = PlanetState.EXPLODING;
    explosionSprite = new AnimatedSprite(AnimatedSpriteResource.EXPLOSION, 2.25, 1);
    SoundResource.DEATH_FLASH.get().play();
  }
}
