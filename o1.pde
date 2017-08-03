import java.util.List;
import java.util.ArrayList;

class Particle {
  public int x, y;
  public Particle(int x_, int y_) {
    x = x_;
    y = y_;
  }

  public void draw() {
    noStroke();
    fill(0x33, 0xff, 0xff);
    rect(x, y, 1, 1);
  }

  public void randomWalk() {
    // 0 1 2
    // 3 _ 4
    // 5 6 7
    switch((int)random(8)) {
      case 0: 
        x--;
        y++;
        break;
      case 1:
        y++;
        break;
      case 2:
        x++;
        y++;
        break;
      case 3:
        x--;
        break;
      case 4:
        x++;
        break;
      case 5:
        y--;
        x--;
      case 6:
        y--;
        break;
      case 7:
        x++;
        y--;
        break;
    }

    if (x < 0 || x > width || y < 0 || y > height) {
      x = (int)random(width);
      y = (int)random(height);
    }
  }
}

class Cluster {
  public List<Particle> particles;
  public Cluster() {
    particles = new ArrayList<Particle>();
    particles.add(new Particle(width/2, height/2));
  }

  public void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }

  public void checkCollision(Particle p) {
    for (Particle i : particles) {
      if ((p.x == i.x - 1 || p.x == i.x + 1 ) &&
          (p.y == i.y - 1 || p.y == i.y + 1)) {
        particles.add(p);

        p = new Particle((int)random(width), (int)random(height));
      }
    }
  }
}

Cluster c;

void setup() {
  size(900, 900);
  c = new Cluster();
  initCluster(c);
}

void draw() {
  background(0xff, 0, 0xff);

  c.draw();
}

void initCluster(Cluster c) {
