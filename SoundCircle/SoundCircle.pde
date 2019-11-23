
import ddf.minim.*;

Minim minim;
AudioInput in;

int n = 10000;

float[] m = new float[n];
float[] x = new float[n];
float[] y = new float[n];
float[] vx = new float[n];
float[] vy = new float[n];
int global_x = 0;
int global_y = 0;

int hue;

boolean two_flag = false;

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void setup() {
  fullScreen(P3D);
  fill(0, 20);
  reset();
  colorMode(HSB);
  minim = new Minim(this);
  in = minim.getLineIn(1);
  in.disableMonitoring();
}


void draw() {
  noStroke();
  hue = abs(frameCount%360);
  rect(0, 0, width, height);

  float volumn = abs(in.right.get(0));

  if (volumn > 0.99) {
    global_x = int(random(0, width));
    global_y = int(random(0, height));
    int rand_flag = int(random(0, 100));
    if (rand_flag % 2 == 0) {
      if (two_flag == false) {
        two_flag = true;
      } else {
        two_flag = false;
      }
    }
    reset();
  } else {
    global_x += int(random(-volumn*80, volumn*80));
    global_y += int(random(-volumn*80, volumn*80));
  }

  for (int i = 0; i < n; i++) {
    float dx = global_x - x[i];
    float dy = global_y - y[i];

    float d = sqrt(dx*dx + dy*dy);
    if (d < 1) d = 1;

    float f = sin(d * 0.03) * m[i] / d;

    vx[i] = vx[i] * 0.5 + f * dx;
    vy[i] = vy[i] * 0.5 + f * dy;
  }


  for (int i = 0; i < n; i++) {
    x[i] += vx[i];
    y[i] += vy[i];

    if (x[i] < 0) x[i] = width;
    else if (x[i] > width) x[i] = 0;

    if (y[i] < 0) y[i] = height;
    else if (y[i] > height) y[i] = 0;

    color c1 = color(hue, random(0, 255), random(0, 255));
    color c2 = color(360-hue, 255, 255);

    strokeWeight(2);
    if (m[i] < 0) stroke(c1);
    else stroke(c2);

    point(x[i], y[i]);
  }



  if (two_flag == true) {
    for (int i = 0; i < n; i++) {
      float dx = width - global_x - x[i];
      float dy = global_y - y[i];

      float d = sqrt(dx*dx + dy*dy);
      if (d < 1) d = 1;

      float f = sin(d * 0.03) * m[i] / d;

      vx[i] = vx[i] * 0.5 + f * dx;
      vy[i] = vy[i] * 0.5 + f * dy;
    }
    for (int i = 0; i < n; i++) {
      x[i] += vx[i];
      y[i] += vy[i];

      if (x[i] < 0) x[i] = width;
      else if (x[i] > width) x[i] = 0;

      if (y[i] < 0) y[i] = height;
      else if (y[i] > height) y[i] = 0;

      color c1 = color(hue, random(0, 255), random(0, 255));
      color c2 = color(360-hue, 255, 255);

      strokeWeight(2);
      if (m[i] < 0) stroke(c1);
      else stroke(c2);

      point(x[i], y[i]);
    }
  }
}


void reset() {
  for (int i = 0; i < n; i++) {
    m[i] = randomGaussian() * 2;
    x[i] = random(width);
    y[i] = random(height);
  }
}
