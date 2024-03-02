// created to save imported images and its positions to draw
ArrayList<Image> importedImagesArray = new ArrayList<Image>();

class Image{
  PImage image;
  float startX, startY;
  
  Image(PImage image_, float startX_, float startY_){
    image = image_;
    startX = startX_;
    startY = startY_;
  }
  void draw(){
    image(image, startX, startY);
  }
}
