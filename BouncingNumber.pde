class BouncingNumber {
  
  private int min;
  private int max;
  
  private int current;
  private boolean up;
  
  BouncingNumber(int min, int max, int initial) {
    this.min = min;
    this.max = max;
    current = initial;
    up = true;
  }

  int get() {
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
    
    return current;
  }
}
