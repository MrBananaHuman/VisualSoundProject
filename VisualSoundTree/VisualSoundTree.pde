import ddf.minim.*;

Minim minim;
AudioInput in;
float ang;
float rotate = 0;
boolean resetFlag = false;
int hue;
color c1;
int dupeCount = 0;
int sizeFactor = 100;
int minSizeFactor = 100;
int maxSizeFactor = 300;
int rootNum = 8;
boolean backFlag = false;

void setup(){
  fullScreen(P3D);
  background(200);
  minim = new Minim(this);
  in = minim.getLineIn(1);
  in.disableMonitoring();
}

void draw(){
  background(0);
  colorMode(HSB);
  float volumn = abs(in.right.get(0));
  dupeCount += 1;
  hue = abs(frameCount%360);
  c1 = color(hue, 255, 255);
  strokeWeight(1);
  stroke(220); 
  if(volumn < 0.8){
    if(volumn < 0.5){
      volumn = 0.7;
    }
    rootNum = int(volumn * 10); 
    camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    minSizeFactor = 100;
    sizeFactor = minSizeFactor;
    maxSizeFactor = 300;
  } else if(volumn < 0.9){
    camera(width/2.0 + random(-500, 500), height/2.0, (height/2.0) / tan(PI*30.0 / 180.0)-100, width/2.0, height/2.0, 0, 0, 1, 0);
    stroke(c1);
  } else{
    camera(width/2.0 + random(-500, 500), height/2.0, (height/2.0) / tan(PI*30.0 / 180.0)-100, width/2.0, height/2.0, 0, 0, 1, 0);
    stroke(c1);
    minSizeFactor = 300;
    sizeFactor = minSizeFactor;
    maxSizeFactor = 500;
  }

  int size = sizeFactor;
  drawFracs(width/2, height/2, size, rootNum);
  ang = map(frameCount*10, 0, width, 0, PI/2);  
}

void drawFracs(int x, int y, int size, int num){
  frac(x, y, 4*PI/2, size, num);
  frac(x, y, 3*PI/2, size, num);
  frac(x, y, 2*PI/2, size, num);
  frac(x, y, 1*PI/2, size, num);
}

void frac(float x, float y, float a, float l, float d){
  strokeWeight(d);
  line(x, y, x+l*cos(a), y+l*sin(a));
  if(d > 0){
    frac(x+l*cos(a), y+l*sin(a), a+ang, l*0.7, d-1);
    frac(x+l*cos(a), y+l*sin(a), a-ang, l*0.7, d-1);
  }
}
