class Intro {

  Star[] stars = new Star[2000];
  
  Runnable endCallback;
  float speed = 1;
  boolean increasing = true;
  boolean running = false;
  
  Intro(Runnable endCallback) {
    this.endCallback = endCallback;

    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Star();
    }
  }
  
  void start() {
    running = true;
  }
  
  void show() {
    translate(width / 2, height / 2);
    
    pushStyle();
    
    if (running) {
      if (increasing) {
        speed *= 1.05;
        
        if (speed > 255) {
          increasing = false;
        }
      } else {
        speed /= 1.10;
        
        if (speed < 0.25) {
          endCallback.run();
        }
      }
    }
    
    if (increasing || speed > 50) {
      for (int i = 0; i < stars.length; i++) {
        stars[i].update(speed);
        stars[i].show(255);
      }
    } else {
      for (int i = 0; i < stars.length; i++) {
        stars[i].update(speed);
        stars[i].show(map(speed, 0, 50, 0, 255));
      }
    }
    
    popStyle();
  }
}
