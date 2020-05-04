class Star {
  private float x;
  private float y;
  private float z;

  private float prevZ;

  public Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    prevZ = z;
  }

  public void show(float speed, float opacity) {
    float x1 = map(x / z, 0, 1, 0, width);
    float y1 = map(y / z, 0, 1, 0, height);

    float x2 = map(x / prevZ, 0, 1, 0, width);
    float y2 = map(y / prevZ, 0, 1, 0, height);

    // Slightly red color when high speed, otherwise white.
    float inverse = 255 - map(speed, 0, 255, 0, 150);
    stroke(255, inverse, inverse, opacity);

    line(x2, y2, x1, y1);
  }

  public void update(float speed) {
    prevZ = z;
    z = z - speed;
    if (z < 1) {
      x = random(-width, width);
      y = random(-height, height);
      z = width;
      prevZ = z;
    }
  }
}
