class Bullet {

  PImage sprite;
  float origWidth;
  float origHeight;
  
  float scaleFactor;
  PVector position;
  float angle;
  PVector origPosition;
  PVector destPosition;
  
  float lerpFactor = 0;
  
  Bullet(PImage sprite, float initialScaleFactor, PVector position, float angle, PVector destPosition) {
    this.sprite = sprite;
    origWidth = width * initialScaleFactor;
    origHeight = height * initialScaleFactor;
    scaleFactor = initialScaleFactor;
    
    this.position = position;
    origPosition = position.copy();
    this.angle = angle;
    this.destPosition = destPosition;
  }
  
  void show() {
    pushMatrix();
    
    translate(position.x, position.y);
    rotate(angle);

    float w = origWidth * (1 - lerpFactor);
    float h = origHeight * (1 - lerpFactor);

    image(
      sprite,
      - w / 2,
      - h / 2,
      w,
      h
    );
    
    popMatrix();
  }
  
  void update() {
    if (lerpFactor < 1) {
      position = PVector.lerp(origPosition, destPosition, lerpFactor);
      lerpFactor += 0.02;
    }
  }
}
