class BouncingInteger {
  
  private int min;
  private int max;
  
  private int current;
  private boolean up;
  
  private int changeRate;
  private int counter = 0;
  
  BouncingInteger(int min, int max, int initial) {
    this(min, max, initial, 1);
  }
  
  BouncingInteger(int min, int max, int initial, int changeRate) {
    this.min = min;
    this.max = max;
    current = initial;
    up = true;
    this.changeRate = changeRate;
  }

  int get() {
    if (counter == changeRate) {
      counter = 0;

      if (up) {
        if (current == max) {
          up = false;
          current -= 1;
        } else {
          current += 1;
        }
      } else {
        if (current == min) {
          up = true;
          current += 1;
        } else {
          current -= 1;
        }
      }
    } else {
      counter++;
    }

    return current;
  }
}

class BouncingFloat {
  
  private float min;
  private float max;
  private float changeFactor;

  private float current;
  private boolean up;
  
  BouncingFloat(float min, float max, float initial, float changeFactor) {
    this.min = min;
    this.max = max;
    this.current = initial;
    this.changeFactor = changeFactor;
  }

  float get() {
    if (up) {
      if (current >= max) {
        up = false;
        current -= changeFactor;
      } else {
        current += changeFactor;
      }
    } else {
      if (current <= min) {
        up = true;
        current += changeFactor;
      } else {
        current -= changeFactor;
      }
    }
    
    return current;
  }
}
