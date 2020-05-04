class Bullet {

  private PVector position;
  private float angle;

  private float originWidth;
  private float originHeight;

  private PVector origin;
  private PVector target;

  private Runnable callback;

  private float lerpFactor = 0;

  /**
   * Bullet.
   * 
   * @param position initial position
   * @param angle    rotation angle
   * @param scale    initial scale factor
   * @param target   target position
   * @param callback run when the bullet hits its target
   */
  Bullet(PVector position, float angle, float scale, PVector target, Runnable callback) {
    this.position = position;
    this.angle = angle;

    originWidth = width * scale;
    originHeight = height * scale;

    this.origin = position.copy();
    this.target = target;

    this.callback = callback;
  }

  public void show() {
    pushMatrix();

    translate(position.x, position.y);
    rotate(angle);

    float w = originWidth * (1 - lerpFactor);
    float h = originHeight * (1 - lerpFactor);

    image(
      ImageResource.BULLET.get(),
      - w / 2,
      - h / 2,
      w,
      h
    );

    popMatrix();
  }

  public void update() {
    if (lerpFactor < 1) {
      position = PVector.lerp(origin, target, lerpFactor);
      lerpFactor += 0.04;
    } else {
      callback.run();
    }
  }
}
