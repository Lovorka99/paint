class Gumb {

  float x = 0, y = 0;
  float w = 50, h = 50;
  float xPom, yPom;
  float textSize = 12;
  color rectColor = color(185, 59, 59); // red
  color textColor = color(0);
  String text = "";
  int lineWidth = 1;
  int lineColor = 0;
  String name = "";
  String imageName = "";
   // flag for ie right part of ui
   // if more buttons are drawn at the same position of the screen,
   // flag helps detect which button is the one selected
  boolean isVisible = true;

  Gumb(String text_) {
    text = text_;
    name = text;
  }
  Gumb(color rectColor_) {
    rectColor = rectColor_;
  }

  Gumb(float x_, float y_) {
    x = x_;
    y = y_;
  }
  
  Gumb(float x_, float y_, color rectColor_) {
    x = x_;
    y = y_;
    rectColor = rectColor_;
  }

  Gumb(float x_, float y_, String text_) {
    x = x_;
    y = y_;
    text = text_;
  }

  Gumb(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }
  
    Gumb(float x_, float y_, float w_, float h_, color rectColor_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    rectColor = rectColor_;
  }
  
    Gumb(float x_, float y_, float w_, float h_, String text_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    text = text_;
  }

  // Crtaj na početnim koordinatama
  void nacrtajGumb() {
    fill(rectColor);
    strokeWeight(lineWidth);
    stroke(lineColor);
    rect(x, y, w, h);
    fill(color(0)); // defaultna boja teksta
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x + w / 2, y + h / 2);
  }

  // Crtaj ga pomaknutog
  void nacrtajGumb( float x_, float y_ ) {
    fill(rectColor);
    rect(x_, y_, w, h);
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x_ + w / 2, y_ + h / 2);
    xPom = x_;
    yPom = y_;
  }

  // Crtaj sa zadanom bojom
  void nacrtajGumb(color boja) {
    fill(boja);
    rect(x, y, w, h);
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x + w / 2, y + h / 2);
  }

  //detektira je li mis unutar gumba
  boolean unutar() {
    if ( mouseX >= x && mouseX <= x + w 
      && mouseY >= y && mouseY <= y + h) {
      return true;
    } 
    return false;
  }

  void prikaziSliku(String slika) {
    PImage img = loadImage(slika);
    img.resize(20, 20);
    image(img, x + w/2 - 10, y + h/2 - 10);
  }

   void nacrtajSliku() {
    PImage img = loadImage(imageName);
    img.resize(20, 20);
    image(img, x + w/2 - 10, y + h/2 - 10);
  }
  
  void dodajSliku(String slika){
    imageName = slika;
  }
  
  void postaviPoziciju(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void updateVisibility() {
    isVisible = !isVisible;
  }
  
  void selectedVisualUpdate() {
    lineWidth = 4;
    w -= lineWidth;
    x += (lineWidth + 1)/2;
    h -= lineWidth;
    y += (lineWidth + 1)/2;
  }
  
  void unSelectedVisualUpdate() {
    w += lineWidth;
    x -= (lineWidth + 1)/2;
    h += lineWidth;
    y -= (lineWidth + 1)/2;
    lineWidth = 1;
  }
}
