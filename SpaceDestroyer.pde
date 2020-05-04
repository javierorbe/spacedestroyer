import processing.sound.*;

PImage stars;

ArrayList<Planet> planets = new ArrayList<Planet>();
Ship ship;

enum SimulationState {
  INTRO,
  MAIN,
  SHOOTING,
}

SimulationState simulationState;

Intro intro;

BouncingInteger backgroundAnimation = new BouncingInteger(180, 255, 255);

PFont titleFont;

Planet selectedPlanet = null;

void setup() {
  size(1500, 750, P2D);
  surface.setTitle("Space Destroyer");
  surface.setResizable(false);
  frameRate(24);

  ImageResource.load(this);
  AnimatedSpriteResource.load(this);
  SoundResource.load(this);

  titleFont = createFont("spacebar_font.ttf", 64);
 
  stars = loadImage("stars.png");
  stars.resize(width, height);

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
      if (selectedPlanet != null && !selectedPlanet.isAlive()) {
        selectedPlanet = null;
      }
      simulationState = SimulationState.MAIN;
    }
  });
 
  simulationState = SimulationState.INTRO;
  intro = new Intro(this, new Runnable() {
    @Override
    public void run() {
      simulationState = SimulationState.MAIN;
      intro = null;
    }
  });
  
  SoundResource.BACKGROUND.get().loop();
}

void draw() {
  // Hack to avoid lag spike when rendering showMain() for the first time.
  if (frameCount == 1) {
    showMain(0);
  }

  // Debug frame rate.
  // println(frameRate);

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
  
  if (simulationState == SimulationState.INTRO) {
    image(ImageResource.VIOLET_DUST.get(), 0, 0);
    image(ImageResource.BLUE_DUST.get(), 0, 0);
    image(ImageResource.YELLOW_DUST.get(), 0, 0);
  } else {
    pushStyle();
    tint(255, backgroundAnimation.get());
    image(ImageResource.VIOLET_DUST.get(), 0, 0);
    image(ImageResource.BLUE_DUST.get(), 0, 0);
    image(ImageResource.YELLOW_DUST.get(), 0, 0);
    popStyle();
  }

  image(ImageResource.HOT_NEBULA.get(), 0, 0);
  image(ImageResource.COLD_NEBULA.get(), 0, 0);
  image(ImageResource.SMALL_PLANETS.get(), 0, 0);

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
