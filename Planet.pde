enum PlanetState {
  ALIVE,
  EXPLODING,
  DEAD
}

class Planet {
  
  ImageResource resource;
  float realRadius; // Real radius of the planet in the image
  
  PVector position;
  boolean rotateClockwise;
  
  PlanetState state = PlanetState.ALIVE;
  
  private AnimatedSprite explosionSprite;
  
  Planet(PVector position, ImageResource resource, float realRadius, boolean rotateClockwise) {
    this.position = position;
    this.resource = resource;
    this.realRadius = realRadius;
    this.rotateClockwise = rotateClockwise;
  }
  
  public boolean isAlive() {
    return state == PlanetState.ALIVE;
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
    
    PImage img = resource.get();
    
    pushStyle();
    tint(255, opacity);
    image(img, -img.width / 2, -img.height / 2);
    
    stroke(0, 255, 0);
    noFill();
    circle(0, 0, realRadius);
    
    popStyle();
    
    popMatrix();
  }
  
  public boolean testClick() {
    float f1 = mouseX - position.x;
    float f2 = mouseY - position.y;
    float dist = sqrt(f1 * f1 + f2 * f2);
    return dist < realRadius;
  }
  
  void explode() {
    state = PlanetState.EXPLODING;
    explosionSprite = new AnimatedSprite(AnimatedSpriteResource.EXPLOSION, 2.25, 1);
    SoundResource.DEATH_FLASH.get().play();
  }
}
