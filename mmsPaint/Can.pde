class Can {
  void colorCan(color c, DrawArea area) {
    if (mousePressed) {
      loadPixels();
      color currentColor = pixels[mouseY * width + mouseX];
      int xMouse = int(mouseX), yMouse = int(mouseY), originalMouseX = int(mouseX), originalMouseY = int(mouseY);
      while (pixels[yMouse * width + xMouse] == currentColor && yMouse < area.down) {
        coloringL(c, currentColor, xMouse, yMouse, area);
        yMouse++;
      }
      yMouse = originalMouseY - 1;
      while (pixels[yMouse * width + xMouse] == currentColor && yMouse > area.up) {
        coloringL(c, currentColor, xMouse, yMouse, area);
        yMouse--;
      }
      yMouse = originalMouseY; xMouse = originalMouseX + 1;
      while (pixels[yMouse * width + xMouse] == currentColor && yMouse < area.down) {
        coloringR(c, currentColor, xMouse, yMouse, area);
        yMouse++;
      }
      yMouse = originalMouseY - 1; xMouse = originalMouseX + 1;
      while (pixels[yMouse * width + xMouse] == currentColor && yMouse > area.up) {
        coloringR(c, currentColor, xMouse, yMouse, area);
        yMouse--;
      }
      updatePixels();
    }
  }
  
  void coloringL(color c, color currentColor, int xMouse, int yMouse, DrawArea area) {
    if (yMouse > area.down || yMouse < area.up || xMouse > area.right || xMouse < area.left) return;
    if (currentColor != pixels[yMouse * width + xMouse]) return;
    pixels[yMouse * width + xMouse] = c;
    coloringL(c, currentColor, xMouse - 1, yMouse, area);
  }
  
  void coloringR(color c, color currentColor, int xMouse, int yMouse, DrawArea area) {
    if (yMouse > area.down || yMouse < area.up || xMouse > area.right || xMouse < area.left) return;
    if (currentColor != pixels[yMouse * width + xMouse]) return;
    pixels[yMouse * width + xMouse] = c;
    coloringR(c, currentColor, xMouse + 1, yMouse, area);
  }
}
