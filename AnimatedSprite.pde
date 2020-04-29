class AnimatedSprite {
  PImage[] frames;
  int frameCount;
  int frameIndex = 0;
  int changeRate;
  int counter = 0;
  
  AnimatedSprite(String imageName, int count, float scale, int changeRate) {
    frames = new PImage[count];
    frameCount = count;
    this.changeRate = changeRate;
    for (int i = 0; i < count; i++) {
      frames[i] = loadImage(imageName + "_" + i + ".png");
      frames[i].resize(floor(frames[i].width * scale), floor(frames[i].height * scale));
    }
  }
  
  void show(float posX, float posY) {
    if (frameIndex == frameCount) {
      frameIndex = 0;
    }
    
    PImage frame = frames[frameIndex];
    
    image(frame, posX - frame.width / 2, posY - frame.height / 2);
    
    if (counter == changeRate) {
      frameIndex++;
      counter = 0;
    } else {
      counter++;
    }
  }
}
