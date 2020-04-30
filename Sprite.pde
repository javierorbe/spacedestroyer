class Sprite {
  private ImageResource resource;
  private float scale;
  
  Sprite(ImageResource resource, float scale) {
    this.resource = resource;
    this.scale = scale;
  }
  
  void show(float posX, float posY) {
    PImage img = resource.get();
    
    float w = img.width * scale;
    float h = img.height * scale;
    
    image(
      img,
      posX - w / 2,
      posY - h / 2,
      w,
      h
    );
  }
}
