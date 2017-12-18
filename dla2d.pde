import java.util.List;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;

class Particle {
  public int x, y;
  public Particle(int x_, int y_) {
    x = x_;
    y = y_;
  }

  public void draw() {
    noStroke();
    fill(0x0, 0x0, 0x0);
    ellipse(x, y, 6, 6);
  }
}

class Cluster {
  public List<Particle> particles;
  public Cluster() {
    particles = new ArrayList<Particle>();
  }

  public void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }
  
  public void addParticle(int x, int y) {
    particles.add(new Particle(x, y));
  }
}

Cluster c;

void setup() {
  size(900, 900);
  c = new Cluster();
  initCluster(c);
}

void draw() {
  background(0xff, 0xff, 0xff);

  c.draw();
}

void initCluster(Cluster c) {
  String[] lines = loadStrings("result.csv");
  for (int i = 0; i < lines.length; i++) {
    String[] coords = lines[i].split(",");
    int x = Integer.parseInt(coords[0]);
    int y = Integer.parseInt(coords[1]);
    x = int(map(x, 95, 195, 0, 900));
    y = int(map(y, 140, 210, 0, 900));
    c.addParticle(x, y);
    }
}