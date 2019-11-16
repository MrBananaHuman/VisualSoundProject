ParticleSystem ps ;
import ddf.minim.*;

Minim minim;
AudioInput in;

float volumn = 0;
int hue = 0;

void setup() {

  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100);
  ps = new ParticleSystem();
  minim = new Minim(this);
  in = minim.getLineIn(1);
  in.disableMonitoring();
}

void draw() {

  noStroke();
  background(0);
  volumn = abs(in.right.get(0));
  camera(width/2.0 + mouseX, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  ps.addParticle();
  ps.run();
}


class Particle {



  PVector prev, pos, spd, acc, noiseVector;



  float  noiseScaleX ;
  float  noiseScaleY ;
  float  noiseScaleZ ;
  float n;
  float angle;
  float life;


  public Particle() {
    noiseScaleX = 1500;
    noiseScaleY = 1500;
    noiseScaleZ = random(100, 200);
    life = 300;

    pos = new PVector(random(width/2-100, width/2+100), random(height/2-250, height/2-150) - (volumn * 100));
    spd = new PVector(5, 0);
    acc = new PVector(0, 0);
  }


  void update2() {

    n = noise(pos.x / noiseScaleX, pos.y / noiseScaleY);

    spd  = new PVector(cos(angle), sin(angle));
    noiseVector = new PVector(random(-10, 10) * volumn, random(-10, 10) * volumn);
    =
      spd.add(acc);

    spd.mult(10 + 20 * volumn);
    angle = angle + 0.05;
    pos.add(spd);
    if (volumn > 0.9) {
      int size = int(random(1, 20));
      int check_num = int(random(0, 100));
      if (check_num % 100 == 0) {
        color c2 = color(255-hue, 255, 255);
        fill(c2);
        ellipse(pos.x, pos.y, size, size);
      }
    }
    life -= 0.5;
  }

  void display() {
    strokeWeight(random(0, 10));
    hue = abs(frameCount%360);
    color c1 = color(hue, 255, 255);

    stroke(c1);
    ellipse(pos.x, pos.y, random(0.8, 1), random(0.8, 1));
  }

  Boolean isDead() {
    if (life<=0) {
      return true;
    } else {
      return false;
    }
  }
}


class ParticleSystem {

  ArrayList<Particle> p ;
  ArrayList<Particle> p2 ;

  ParticleSystem() {

    p = new ArrayList<Particle>();
    p2 = new ArrayList<Particle>();
  }


  void run() {

    for (int i = 0; i<p.size(); i++) {

      p.get(i).update2();
      p.get(i).display();

      p2.get(i).update2();
      p2.get(i).display();

      if (p.get(i).isDead()) {
        p.remove(i);
      }
      if (p2.get(i).isDead()) {
        p2.remove(i);
      }
    }
  }

  void addParticle() {

    p.add(new Particle());
    p2.add(new Particle());
  }
}
