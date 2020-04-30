import processing.sound.*;

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
  SHOOTING,
}

static SimulationState simulationState;

Intro intro;

BouncingNumber backgroundAnimation = new BouncingNumber(200, 255, 255);

PFont titleFont;

Planet selectedPlanet = null;

void setup() {
  size(1500, 750, P2D);
  frameRate(24);

  ImageResource.load(this);
  AnimatedSpriteResource.load(this);
  SoundResource.load(this);

  titleFont = createFont("spacebar_font.ttf", 32);
 
  stars = loadImage("stars.png");
  stars.resize(width, height);
 
  violetDust = loadImage("violet_dust.png");
  blueDust = loadImage("blue_dust.png");
  yellowDust = loadImage("yellow_dust.png");
  hotNebula = loadImage("hot_nebula.png");
  coldNebula = loadImage("cold_nebula.png");
  smallPlanets = loadImage("small_planets.png");
 
  planets.add(new Planet(new PVector(1300, 200), ImageResource.SUN, 100, true));
  planets.add(new Planet(new PVector(1200, 450), ImageResource.RED_GIANT, 108, false));
  planets.add(new Planet(new PVector(390, 175), ImageResource.GAS_GIANT, 108, false));
  planets.add(new Planet(new PVector(250, 410), ImageResource.ICE_GIANT, 108, true));
  planets.add(new Planet(new PVector(950, 575), ImageResource.EXOPLANET1, 88, true));
  planets.add(new Planet(new PVector(660, 610), ImageResource.EXOPLANET2, 80, false));
  planets.add(new Planet(new PVector(425, 640), ImageResource.EXOPLANET3, 75, true));

  ship = new Ship(new PVector(width / 2, height / 2), loadImage("bullet.png"), new Runnable() {
    @Override
    public void run() {
      selectedPlanet = null;
      simulationState = SimulationState.MAIN;
    }
  });
 
  simulationState = SimulationState.INTRO;
  intro = new Intro(new Runnable() {
    @Override
    public void run() {
      simulationState = SimulationState.MAIN;
      intro = null;
    }
  });
}

void draw() {
  // Hack to avoid lag spike when rendering showMain() for the first time.
  if (frameCount == 1) {
    showMain(0);
  }
  
  println(frameRate);
  if (simulationState == SimulationState.INTRO) {
    if (intro.running) {
      if (!intro.increasing && intro.speed < 100) {
        // float op = 255 - map(sqrt(intro.speed), 0, 10, 0, 255);
        float op = 255 - map(intro.speed, 0, 100, 0, 255);
        showMain(op);
      } else {
        background(0);
      }
    } else {
      background(0);
      textAlign(CENTER);
      textFont(titleFont, 64);
      text("Space Destroyer", width / 2, height / 2);
      textFont(titleFont, 16);
      text("Press the space bar", width / 2, height - 128);
    }
    
    intro.show();
  } else if (simulationState == SimulationState.MAIN || simulationState == SimulationState.SHOOTING) {
    showMain(255);
  }
}

void showMain(float opacity) {
  background(0);
  
  pushStyle();
  tint(255, opacity);
  
  image(stars, 0, 0);
  
  if (simulationState == SimulationState.MAIN) {
    pushStyle();
    tint(255, backgroundAnimation.get());
    image(violetDust, 0, 0);
    image(blueDust, 0, 0);
    image(yellowDust, 0, 0);
    popStyle();
  } else {
    image(violetDust, 0, 0);
    image(blueDust, 0, 0);
    image(yellowDust, 0, 0);
  }
  
  image(hotNebula, 0, 0);
  image(coldNebula, 0, 0);
  image(smallPlanets, 0, 0);

  for (Planet p : planets) {
    p.show();
  }

  ship.show();
  popStyle();
  
  ship.update();
}

void keyPressed() {
  if (key == ' ') {
    if (simulationState == SimulationState.INTRO) {
      intro.start();
    }
  }
}

void mouseClicked() {
  if (simulationState == SimulationState.MAIN) {
    if (selectedPlanet != null) {
      simulationState = SimulationState.SHOOTING;
      ship.attack(selectedPlanet);
    }
  }
}

void mouseMoved() {
  selectedPlanet = null;
  
  for (Planet p : planets) {
    if (p.isAlive() && p.isMouseOver()) {
      selectedPlanet = p;
      break;
    }
  }
  
  if (selectedPlanet != null) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
}
