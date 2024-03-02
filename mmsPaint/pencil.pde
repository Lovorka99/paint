import java.util.ArrayList;

ArrayList<PVector> dots = new ArrayList<PVector>();

class Pencil {
  float r, g, b;
  
  void pen(int c, int w, DrawArea area) {
    if (mousePressed) {
      stroke(c);
      strokeWeight(w);
      PVector point1 = new PVector(pmouseX, pmouseY), point2 = new PVector(mouseX, mouseY);
      drawLine(point1, point2, area);
    }
  }
  
  void eraser(int c, int w, DrawArea area) {
    if (mousePressed) {
      stroke(c);
      strokeWeight(2 * w);
      PVector point1 = new PVector(pmouseX, pmouseY), point2 = new PVector(mouseX, mouseY);
      drawLine(point1, point2, area);
    }
  }
  
  void magicPen(int w, DrawArea area) {
    if (mousePressed) {
      dots.add(new PVector(mouseX, mouseY));
      if (mouseX > area.left && mouseX < area.right && mouseY > area.up && mouseY < area.down) {
        drawDots(w);
      }
      r = random(255); g = random(255); b = random(255);
    } else {
      // remove all duplicates of points and dots
      PVector point1, point2;
      for (int i = dots.size() - 1; i > 0; i--) {
        point1 = dots.get(i); point2 = dots.get(i - 1);
        if ((point1.x == point2.x && point1.y == point2.y)) {
          dots.remove(i);
        }
      }
  
      float r2 = random(255), g2 = random(255), b2 = random(255);  
      float rx = (r2 - r)/10, gx = (g2 - g)/10, bx = (b2 - b)/10;
      for (int i = 0; i < dots.size() - 1; i++) {
        stroke(r, g, b);
        strokeWeight(w);
        point1 = dots.get(i); point2 = dots.get(i + 1);
        drawLine(point1, point2, area);
        r += rx;
        g += gx;
        b += bx;
        if (i % 10 == 9) {
          r2 = random(255); g2 = random(255); b2 = random(255); 
          rx = (r2 - r)/10; gx = (g2 - g)/10; bx = (b2 - b)/10;
        }
      }
      dots.clear(); 
    }
  }
  
  void gradientPen(int w, color c, color c2, DrawArea area) {
    if (mousePressed) {
      dots.add(new PVector(mouseX, mouseY));
      if (mouseX > area.left && mouseX < area.right && mouseY > area.up && mouseY < area.down) {
        drawDots(w);
      }
    } else {
      // remove all duplicates of points and dots
      PVector point1, point2;
      for (int i = dots.size() - 1; i > 0; i--) {
        point1 = dots.get(i); point2 = dots.get(i - 1);
        if ((point1.x == point2.x && point1.y == point2.y)) {
          dots.remove(i);
        }
      }
  
      r = red(c); g = green(c); b = blue(c);
      float r2 = red(c2), g2 = green(c2), b2 = blue(c2);
      float rx = (r2 - r)/dots.size(), gx = (g2 - g)/dots.size(), bx = (b2 - b)/dots.size();
      for (int i = 0; i < dots.size() - 1; i++) {
        stroke(r, g, b);
        strokeWeight(w);
        point1 = dots.get(i); point2 = dots.get(i + 1);
        drawLine(point1, point2, area);
        r += rx;
        g += gx;
        b += bx;
      }
      dots.clear(); 
    }
  }
  
  void drawDots(int w) {
    fill(0);
    noStroke(); // Turn off outline
    ellipse(mouseX, mouseY, w-1, w-1); // Draw a circle at mouse position
  }
  
  void drawLine(PVector point1, PVector point2, DrawArea area) {
    if ((point1.x < area.left || point1.x > area.right || point1.y < area.up || point1.y > area.down) && (point2.x < area.left || point2.x > area.right || point2.y < area.up || point2.y > area.down)) {
      return;
    }
    PVector point;
    if (point1.x < area.left) {
      point = calcPointX(area.left, point1.x, point2.x, point1.y, point2.y);
      line(point.x, point.y, point2.x, point2.y);
    } else if (point2.x < area.left) {
      point = calcPointX(area.left, point1.x, point2.x, point1.y, point2.y);
      line(point1.x, point1.y, point.x, point.y);
    } else if (point1.x > area.right) {
      point = calcPointX(area.right, point1.x, point2.x, point1.y, point2.y);
      line(point.x, point.y, point2.x, point2.y);
    } else if (point2.x > area.right) {
      point = calcPointX(area.right, point1.x, point2.x, point1.y, point2.y);
      line(point1.x, point1.y, point.x, point.y);
    } else if (point1.y > area.down) {
      point = calcPointY(area.down, point1.y, point2.y, point1.x, point2.x);
      line(point.x, point.y, point2.x, point2.y);
    } else if (point2.y > area.down) {
      point = calcPointY(area.down, point1.y, point2.y, point1.x, point2.x);
      line(point1.x, point1.y, point.x, point.y);
    } else if (point1.y < area.up) {
      point = calcPointY(area.up, point1.y, point2.y, point1.x, point2.x);
      line(point.x, point.y, point2.x, point2.y);
    } else if (point2.y < area.up) {
      point = calcPointY(area.up, point1.y, point2.y, point1.x, point2.x);
      line(point1.x, point1.y, point.x, point.y); 
    } else {
      line(point1.x, point1.y, point2.x, point2.y);
      return;
    }
  }
  
  PVector calcPointX(float edge, float point1, float point2, float point11, float point21) {
    float k = (edge - point2) / (point1 - point2);
    return new PVector(point1 * k + (1 - k) * point2, point11 * k + (1 - k) * point21);
  }
  
  PVector calcPointY(float edge, float point1, float point2, float point11, float point21) {
    float k = (edge - point2) / (point1 - point2);
    return new PVector(point11 * k + (1 - k) * point21, point1 * k + (1 - k) * point2);
  }
}
