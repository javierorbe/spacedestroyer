PImage stars;

PImage violetDust;
PImage blueDust;
PImage yellowDust;
PImage hotNebula;
PImage coldNebula;
PImage smallPlanets;

ArrayList<Planet> planets = new ArrayList<Planet>();
Ship ship;

enum SimulationState {
  INTRO,
  MAIN,
  SHOOTING
}

static SimulationState state;

Intro intro;

BouncingNumber backgroundAnimation = new BouncingNumber(210, 255, 255);

void setup() {
   size(1500, 750);
   frameRate(24);
   
   stars = loadImage("stars.png");
   stars.resize(width, height);
   
   violetDust = loadImage("violet_dust.png");
   blueDust = loadImage("blue_dust.png");
   yellowDust = loadImage("yellow_dust.png");
   hotNebula = loadImage("hot_nebula.png");
   coldNebula = loadImage("cold_nebula.png");
   smallPlanets = loadImage("small_planets.png");
   
   planets.add(new Planet(new PVector(1300, 200), loadImage("sun.png")));
   planets.add(new Planet(new PVector(1200, 450), loadImage("red_giant.png")));

   ship = new Ship(new PVector(width / 2, height / 2));
   
   state = SimulationState.INTRO;
   intro = new Intro(new Runnable() {
     @Override
     public void run() {
       state = SimulationState.MAIN;
       intro = null;
     }
   });
}

void draw() {
  if (state == SimulationState.INTRO) {
    if (intro.running) {
      if (!intro.increasing && intro.speed < 100) {
        pushStyle();
        float op = 255 - map(intro.speed, 0, 100, 0, 255);
        tint(255, op);
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
  
  pushStyle();
  if (state == SimulationState.MAIN) {
    tint(255, backgroundAnimation.get());
  }
  image(violetDust, 0, 0);
  image(blueDust, 0, 0);
  image(yellowDust, 0, 0);
  popStyle();
  image(hotNebula, 0, 0);
  image(coldNebula, 0, 0);
  image(smallPlanets, 0, 0);

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
  
  if (key == 'l') {
    if (state == SimulationState.MAIN) {
      ship.attack(planets.get(1));
    }
  }
}
