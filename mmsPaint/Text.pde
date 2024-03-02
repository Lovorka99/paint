class Text {
  float x, y;
  int textSize = 15;
  String text;
  color textColor = color(0);

  Text(float x_, float y_, int textSize_, String text_, color textColor_) {
    x = x_;
    y = y_;
    textSize = textSize_;
    text = text_;
    textColor = textColor_;
  }

  //defaultna crna boja i velicina teksta 30
  Text(float x_, float y_, String text_) {
    x = x_;
    y = y_;
    text = text_;
  }

  void ispisiText() {
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    text(text, x, y);
  }
}
