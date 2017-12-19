import java.util.List;
import java.util.ArrayList;

// Particle interface to handle both variants, 2d and 3d 
interface Particle {
  public void draw();
}

// Draw 2d particle in 3D space
class Particle2d implements Particle {
  public int x, y;
  public Particle2d(int x_, int y_) {
    x = x_;
    y = y_;
  }

  public void draw() {
    pushMatrix();
    // WIP get min and max and scale autmatically
    int trX = int(map(x, 95, 195, 0, 900));
    int trY = int(map(y, 140, 210, 0, 900));
    translate(trX, trY, 1);
    fill(0x0, 0x0, 0x0);
    ellipseMode(CENTER);
    ellipse(0, 0, 6, 6);
    popMatrix();
  }
}

// WIP
class Particle3d implements Particle {
  public int x, y, z;
  public Particle3d(int x_, int y_, int z_) {
    x = x_;
    y = y_;
    z = z_;
  }
  
  public void draw() { 
    pushMatrix();
    // WIP get min and max and scale autmatically
    int trX = int(map(x, 440, 470, 0, 900));
    int trY = int(map(y, 440, 470, 0, 900));
    int trZ = int(map(z, 440, 470, 0, 900));
    translate(trX, trY, trZ);
    fill(0x0, 0x0, 0x0);
    box(24);
    popMatrix();
  }
}

class Cluster {
  public boolean threeDimmensions;
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
    particles.add(new Particle2d(x, y));
  }
  
  public void addParticle(int x, int y, int z) {
    particles.add(new Particle3d(x, y, z));
  }
}

Cluster c;

void setup() {
  size(900, 900, P3D);
  c = initCluster();
  
  if (c.threeDimmensions) {
    // *very* WIP
    camera(450, 0, 450, 450, 450, 0, 1.0, 1.0, 1.0);
  }
}

void draw() {
  background(0xff, 0xff, 0xff);
  c.draw();
}

Cluster initCluster() {
  Cluster c = new Cluster();
  String[] lines = loadStrings("result.csv");
  for (int i = 0; i < lines.length; i++) {
    String[] coords = lines[i].split(",");
    if (i == 0) {
      if (coords.length == 2) {
        c.threeDimmensions = false;
      } else {
        c.threeDimmensions = true;
      }
    }
    
    int x = Integer.parseInt(coords[0]);
    int y = Integer.parseInt(coords[1]);

    if (coords.length == 2) {
      c.addParticle(x, y);
    } else {
      int z = Integer.parseInt(coords[2]);
      c.addParticle(x, y, z);
    }
  }
    
  return c;
}