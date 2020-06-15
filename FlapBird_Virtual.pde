String state = "Menu";
ArrayList<walls> wall = new ArrayList<walls>();
ArrayList<Integer> gap = new ArrayList<Integer>();
PImage menuBack;
PImage bird;
PImage ground;
long wait;
long wait2;
float birdY = 300;
boolean pressed = false;
boolean hit = false;
boolean sLimit = false;
int score = 0;
float grav = 0.5;
float accel = 1;
int deg = 0;
int gapY2;

void setup() {
  menuBack = loadImage("FlappyBirdBack.jpg");
  bird = loadImage("bird.png");
  ground = loadImage("flapback.png");
  menuBack.resize(1000, 600);
  bird.resize(100, 100);
  ground.resize(1000, 300);
  size(1000, 599);
  background(0, 30, 255);
}
void draw() {
  checkState();
  if (state.equals("Menu")) {
    image(menuBack, 0, 0);
    fill(0, 255, 0);
    rect(50, 350, 200, 100, 8);
    rect(300, 350, 200, 100, 8);
    fill(0);
    textSize(36);
    text("Regular", 85, 415);
    text("Virtual", 340, 415);
  }
  if (state.equals("GameR") || state.equals("GameV")) {
    if (state.equals("GameR")) {
      flap();
    }
    collision();
    background(0, 30, 255);
    image(ground, 0, 300);
    if (millis()-wait>2000) {
      wall.add(new walls(width, int(random(50, 400))));
      wait = millis();
      collision();
    }
    for (int i = 0; i<wall.size(); i++) {
      wall.get(i).draw();
      collision();
    }
    image(bird, 100, birdY);
    collision();
    textSize(56);
    fill(255);
    text(score, 800, 100);
    text(mouseX, 200, 200);
  }
}

void checkState() {
  if (state.equals("Menu")&&mousePressed&&mouseX>=50&&mouseX<=250&&mouseY>=350&&mouseY<=450) {
    state = "GameR";
  }
  if (state.equals("Menu")&&mousePressed&&mouseX>=300&&mouseX<=500&&mouseY>=350&&mouseY<=450) {
    state = "GameV";
  }
}

void flap() {
  birdY+=2*grav;
  grav = grav+0.2;
  if (keyPressed&&key==' '&&!pressed&&!hit) {
    pressed = true;
    grav=-3.5;
  }
}

void keyReleased() {
  if (key==' ') {
    pressed = false;
  }
}

void collision() {
  for (int i = 0; i<wall.size(); i++) {
    if (wall.get(i).x>0&&wall.get(i).x<=180||int(birdY)<gap.get(i)-20) {
      if (birdY>gap.get(i)+180) {
        hit = true;
        grav+=2;
      }
      if (birdY>=gap.get(i)-15&&birdY-90<=gap.get(i)+150) {
        if (200>=wall.get(i).x&&204<=wall.get(i).x) {
          score++;
        }
      }
    }
  }
}


class walls {
  int x;
  int gapY;
  public walls(int x, int gapY) {
    this.x = x;
    this.gapY = gapY;
    gap.add(gapY);
  }
  void draw() {
    fill(0, 255, 0);
    strokeWeight(2);
    rect(x, 0, 100, height-28);
    fill(0, 30, 255);
    noStroke();
    rect(x, gapY, 100, 150);
    if (!hit) {
      x-=4;
    }
  }
}