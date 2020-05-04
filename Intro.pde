class Intro {

  private Star[] stars = new Star[2500];

  private Runnable endCallback;
  private float speed = 1;
  private boolean increasing = true;
  private boolean running = false;

  private SinOsc osc1;
  private SinOsc osc2;
  private SinOsc osc3;

  public Intro(PApplet app, Runnable endCallback) {
    this.endCallback = endCallback;
    this.osc1 = new SinOsc(app);
    this.osc2 = new SinOsc(app);
    this.osc3 = new SinOsc(app);

    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Star();
    }
  }

  public void start() {
    running = true;
    
    osc1.amp(1f);
    osc2.amp(1f / 2.5f);
    osc3.amp(1f / 3.5f);
    osc1.freq(speed * 2);
    osc2.freq(speed * 5);
    osc3.freq(speed * 7);
    osc1.play();
    osc2.play();
    osc3.play();
  }
  
  public void show() {
    translate(width / 2, height / 2);
    
    pushStyle();
    
    if (running) {
      osc1.freq(speed);
      osc2.freq(speed * 2);
      osc3.freq(speed * 3);
      
      if (increasing) {
        speed *= 1.05;
        
        if (speed > 255) {
          increasing = false;
        }
      } else {
        if (speed > 100) {
          speed /= 1.05;
        } else {
          speed /= 1.075;
          
          float ampF = map(speed, 0, 100, 0, 1);
          osc1.amp(ampF);
          osc2.amp(ampF / 2.5f);
          osc3.amp(ampF / 3.5f);
        }
        
        if (speed < 1) {
          osc1.stop();
          osc2.stop();
          osc3.stop();
          endCallback.run();
        }
      }
    }

    if (increasing || speed > 50) {
      for (int i = 0; i < stars.length; i++) {
        stars[i].update(speed);
        stars[i].show(speed, 255);
      }
    } else {
      float op = map(speed, 0, 50, 0, 255);
      for (int i = 0; i < stars.length; i++) {
        stars[i].update(speed);
        stars[i].show(speed, op);
      }
    }
    
    popStyle();
  }
}
