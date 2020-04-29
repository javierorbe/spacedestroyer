static class MathUtil {
  static float shortAngleDist(float a0, float a1) {
    float da = (a1 - a0) % TWO_PI;
    return 2 * da % TWO_PI - da;
  }
  
  static float angleLerp(float a0, float a1, float factor) {
    return a0 + shortAngleDist(a0, a1) * factor;
  }
}
