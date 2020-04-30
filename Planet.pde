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

  private float dustRotation;
  // Asteriods position shift from the center, when planet is dead.
  private HashMap<Integer, PVector> asteroidPos = new HashMap<Integer, PVector>();
  private HashMap<Integer, Float> asteroidRot = new HashMap<Integer, Float>();
  private BouncingFloat asteroidAnimationX = new BouncingFloat(-2, 2, 2, random(0.02, 0.05));
  private BouncingFloat asteroidAnimationY = new BouncingFloat(-2, 2, 0, random(0.02, 0.05));

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
        
        if (op < 175) {
          showAsteroids();
        }
        
        showPlanet(op);
        explosionSprite.show(position.x, position.y);
      } else {
        state = PlanetState.DEAD;
        showAsteroids();
      }
    } else { // DEAD
      showAsteroids();
    }
  }
  
  private void showAsteroids() {
    pushMatrix();
    translate(position.x, position.y);
    
    rotate(dustRotation);
    PImage dust = ImageResource.DUST.get();
    image(
      dust,
      -dust.width / 2,
      -dust.height / 2
    );
    
    float shiftX = asteroidAnimationX.get();
    float shiftY = asteroidAnimationY.get();
    
    for (int i = 0; i < AnimatedSpriteResource.ASTEROID.getFrameCount(); i++) {
      pushMatrix();
      rotate(asteroidRot.get(i));
      PVector off = asteroidPos.get(i);
      image(
        AnimatedSpriteResource.ASTEROID.get()[i],
        off.x + shiftX,
        off.y + shiftY
      );
      popMatrix();
    }
    
    popMatrix();
  }

  private void showPlanet(float factor) {
    pushMatrix();

    translate(position.x, position.y);

    if (rotateClockwise) {
      rotate(radians(frameCount % (360 * 30)) / 30);
    } else {
      rotate(-radians(frameCount % (360 * 30)) / 30);
    }

    PImage img = resource.get();

    if (state == PlanetState.ALIVE) {
      image(img, -img.width / 2, -img.height / 2);
    } else if (state == PlanetState.EXPLODING) {
      if (factor > 150) {
        pushStyle();
        float w = img.width;
        float h = img.height;
        
        if (factor < 175) {
           w *= map(factor, 0, 175, 0, 1);
           h *= map(factor, 0, 175, 0, 1);
        }
        
        image(
          img,
          -w / 2,
          -h / 2,
          w,
          h
        );
        popStyle();
      } 
    }

    popMatrix();
  }

  public boolean isMouseOver() {
    float f1 = mouseX - position.x;
    float f2 = mouseY - position.y;
    float dist = f1 * f1 + f2 * f2;
    float rs = realRadius * realRadius;
    return dist < rs;
  }

  void explode() {
    state = PlanetState.EXPLODING;
    explosionSprite = new AnimatedSprite(AnimatedSpriteResource.EXPLOSION, 2.5, 1);

    dustRotation = random(0, TWO_PI);
    for (int i = 0; i < AnimatedSpriteResource.ASTEROID.getFrameCount(); i++) {
      asteroidPos.put(i, new PVector(random(-realRadius * 0.8, realRadius * 0.8), random(-realRadius * 0.8, realRadius * 0.8)));
      asteroidRot.put(i, random(0, TWO_PI));
    }

    SoundResource.DEATH_FLASH.get().play();
  }
}
