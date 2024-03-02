PImage spray;

void drawSprayCanPreview(float x, float y) {
    image(spray, x, y, 50, 50);
}

void drawSprayCircle(float x, float y, int radius, int density) { // raidus could be fixed value but this allows new feature
  generatedImage.beginDraw();
  generatedImage.stroke(red);
  generatedImage.strokeWeight(2);

  for (int i = 0; i < density; i++) {
    float randomAngle = random(TWO_PI);
    float randomDistance = random(radius);

    float offsetX = cos(randomAngle) * randomDistance;
    float offsetY = sin(randomAngle) * randomDistance;

    float sprayX = x + offsetX;
    float sprayY = y + offsetY;

    drawDot(generatedImage, sprayX - 105, sprayY - 100, 2);
    //generatedImage.line(prevX - 105, prevY - 100, sprayX - 105, sprayY - 100);
    //generatedImage.line(x - 105, y - 100, prevX - 105, prevY - 100);
  }

  generatedImage.endDraw();
}

void drawDot(PGraphics pg, float x, float y, float diameter) {
  pg.beginDraw();
  pg.fill(purple); // selected color - check with anton, purple - mock
  pg.noStroke();
  pg.ellipse(x, y, diameter, diameter);
  pg.endDraw();
}
