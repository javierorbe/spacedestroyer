PImage stars;
PImage violetDust;

ArrayList<Planet> planets = new ArrayList<Planet>();
Ship ship;

enum SimulationState {
  INTRO,
  MAIN
}

static SimulationState state;

Intro intro;

void setup() {
   size(1500, 750);
   frameRate(24);
   
   stars = loadImage("stars.png");
   stars.resize(width, height);
   
   violetDust = loadImage("violet_dust.png");
   violetDust.resize(width, height);
   
   planets.add(new Planet(new PVector(1200, 200), loadImage("planet1.png")));
   ship = new Ship(new PVector(width / 2, height / 2), new AnimatedSprite("enemy", 8, 0.25, 12));
   
   state = SimulationState.INTRO;
   intro = new Intro(new Runnable() {
     @Override
     public void run() {
       state = SimulationState.MAIN;
       intro = null;
     }
   });
}

float factor = 1;

void draw() {
  if (state == SimulationState.INTRO) {
    if (intro.running) {
      if (!intro.increasing && intro.speed < 100) {
        pushStyle();
        tint(255, 255 - map(intro.speed, 0, 100, 0, 255));
        showMain();
        popStyle();
      } else {
        background(0);
      }
    } else {
      background(0);
      textAlign(CENTER);
      text("Press the space bar", width / 2, height - 128);
    }
    
    intro.show();
  } else if (state == SimulationState.MAIN) {
    showMain();
  }
}

void showMain() {
  background(0);
  
  image(stars, 0, 0);
  image(violetDust, -width + frameCount % width, 0);
  image(violetDust, frameCount % (width), 0);
  
  for (Planet p : planets) {
    p.show();
  }
  
  ship.show();
  ship.update();
}

void keyPressed() {
  if (key == ' ') {
    if (state == SimulationState.INTRO) {
      intro.start();
    }
  }
}
