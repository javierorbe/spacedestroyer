class Planet {
  PVector position;
  PImage image;
  boolean rotateClockwise;
  
  Planet(PVector position, PImage image, boolean rotateClockwise) {
    this.position = position;
    this.image = image;
    this.rotateClockwise = rotateClockwise;
  }
  
  void show() {
    pushMatrix();
    
    translate(position.x, position.y);
    
    if (rotateClockwise) {
      rotate(radians(frameCount % (360 * 30)) / 30);
    } else {
      rotate(-radians(frameCount % (360 * 30)) / 30);
    }
    
    image(image, -image.width / 2, -image.height / 2);
    
    popMatrix();
  }
}
