enum SoundResource {
  SHOOT("shoot.wav"),
  DEATH_FLASH("death_flash.wav")
  ;
  
  private String filename;
  private SoundFile sound;
  
  private SoundResource(String filename) {
    this.filename = filename;  
  }
  
  public SoundFile get() {
    return sound;
  }
  
  public static void load(PApplet app) {
    for (SoundResource sr : SoundResource.values()) {
      sr.sound = new SoundFile(app, sr.filename);
    }
  }
}

enum ImageResource {
  ENEMY_IDLE("enemy_idle.png"),
  SUN("sun.png"),
  RED_GIANT("red_giant.png"),
  EXOPLANET1("exoplanet1.png"),
  EXOPLANET2("exoplanet2.png"),
  EXOPLANET3("exoplanet3.png"),
  ICE_GIANT("ice_giant.png"),
  GAS_GIANT("gas_giant.png"),
  ;
  
  private String filename;
  private PImage image;
  
  private ImageResource(String filename) {
    this.filename = filename;
  }
  
  public PImage get() {
    return image;
  }
  
  public static void load(PApplet app) {
    for (ImageResource ir : ImageResource.values()) {
      ir.image = app.loadImage(ir.filename);
    }
  }
}

enum AnimatedSpriteResource {
  ENEMY("enemy", 8),
  EXPLOSION("explosion", 32),
  ASTEROID("asteroid", 10),
  ;

  private String name;
  private int count;
  private PImage[] images;
  
  private AnimatedSpriteResource(String name, int count) {
    this.name = name;
    this.count = count;
    images = new PImage[count];
  }
  
  public PImage[] get() {
    return images;
  }
  
  public int getFrameCount() {
    return count;
  }
  
  public static void load(PApplet app) {
    for (AnimatedSpriteResource r : AnimatedSpriteResource.values()) {
      for (int i = 0; i < r.count; i++) {
        r.images[i] = app.loadImage(r.name + "_" + i + ".png");
      }
    }
  }
}
