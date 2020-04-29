class Planet {
  PVector position;
  PImage image;
  
  Planet(PVector position, PImage image) {
    this.position = position;
    this.image = image;
  }
  
  void show() {
    pushMatrix();
    
    translate(position.x, position.y);
    
    rotate(radians(frameCount % (360 * 32)) / 32);
    
    image(image, -image.width / 2, -image.height / 2);
    
    popMatrix();
  }
}
