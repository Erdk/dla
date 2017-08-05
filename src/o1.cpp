#include <iostream>
#include <vector>
#include <cstdlib>
#include <cassert>

const int width = 900;
const int height = 900;

class Particle {
public:
  int x, y;
    
  Particle(int x_, int y_) {
    x = x_;
    y = y_;
  }

  void randomWalk() {
    // 0 1 2
    // 3 _ 4
    // 5 6 7
    switch(rand() % 8) {
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
      x = rand() % width;
      y = rand() % height;
    }
  }
};

class Cluster {
public:
  std::vector<Particle*> particles;
  Cluster() {
    particles = std::vector<Particle*>();
    particles.push_back(new Particle(width/2, height/2));
  }

  virtual ~Cluster() {
    for (Particle* p : particles) {
      delete p;
    }
  }

  void checkClusterParticleCollision(Particle** p) {
    bool collide = checkCollision(*p);
    if (collide) {
      particles.push_back(*p);

      *p = new Particle(rand() % width, rand() % height);
      //while (!checkCollision(*p)) {
      //  (*p)->x = rand() % width;
      //  (*p)->y = rand() % height;
      //}
    }
  }

  bool checkCollision(Particle* p) {
    for (Particle* i : particles) {
      if ((p->x == i->x - 1 || p->x == i->x || p->x == i->x + 1 ) &&
          (p->y == i->y - 1 || p->y == i->y || p->y == i->y + 1)) {
        return true;
      }
    }

    return false;
  }
};

int main(int argc, const char* argv[]) {
  Cluster c = Cluster();
  Particle* walker = new Particle(rand() % width, rand() % height);
  
  uint64_t tick = 0;

  while(c.particles.size() < 3000) {
    if (c.particles.size() % 300 == 0) {
      std::cerr << (float) c.particles.size() / 30.0 << "%" << std::endl; 
    }
    walker->randomWalk();
    c.checkClusterParticleCollision(&walker);
  }
  
  for (Particle* p : c.particles) {
    std::cout << "c.particles.add(new Particle(" << p->x << ", " << p->y << "));" << std::endl;
  }

  return 0;
}
