class Sprite {
  PImage image;
  
  Sprite(String filename, float scale) {
    image = loadImage(filename);
    image.resize(floor(image.width * scale), floor(image.height * scale));
  }
  
  void show(float posX, float posY) {
    image(image, posX - image.width / 2, posY - image.height / 2);
  }
}
