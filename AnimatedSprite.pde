class AnimatedSprite {
  private AnimatedSpriteResource resource;
  private float scale;
  int frameIndex = 0;
  int changeRate;
  int counter = 0;
  
  AnimatedSprite(AnimatedSpriteResource resource, float scale, int changeRate) {
    this.resource = resource;
    this.scale = scale;
    this.changeRate = changeRate;
  }
  
  public int getFrameCount() {
    return resource.getFrameCount();
  }
  
  public int getFrameIndex() {
    return frameIndex;
  }
  
  void show(float posX, float posY) {
    if (frameIndex == resource.getFrameCount()) {
      frameIndex = 0;
    }
    
    PImage frame = resource.get()[frameIndex];
    
    float w = frame.width * scale;
    float h = frame.height * scale;
    
    image(
      frame,
      posX - w / 2,
      posY - h / 2,
      w,
      h
    );
    
    if (counter == changeRate) {
      frameIndex++;
      counter = 0;
    } else {
      counter++;
    }
  }
}
