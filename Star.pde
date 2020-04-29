class Star {
  float x;
  float y;
  float z;
  
  float pz;
  
  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    pz = z;
  }

  void show(float speed, float opacity) {
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    
    float px = map(x / pz, 0, 1, 0, width);
    float py = map(y / pz, 0, 1, 0, height);
    
    float inverse = 255 - map(speed, 0, 255, 0, 200);
    stroke(255, inverse, inverse, opacity);
    line(px, py, sx, sy);
  }

  void update(float speed) {
    pz = z;
    z = z - speed;
    if (z < 1) {
      x = random(-width, width);
      y = random(-height, height);
      z = width;
      pz = z;
    }
  }
}
