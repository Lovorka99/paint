import controlP5.*;
import ddf.minim.*;

ControlP5 cp5;

PGraphics helpScreen;

PFont font;
int numGenImages = 0;
Textfield generatedImageTextfield;
boolean isSaveVisible = false;
boolean ishouseVisible = false;

int prozor = 0;

////////////////////////
Photo p = new Photo();

color yellow = color(255, 255, 153);
color white = color (255, 255, 255);
color red = color(185, 59, 59);
color marine = color(30, 203, 225);
color purple = color(58, 39, 216);
color lightBackgroundColor = white;
color darkBackgroundColor = yellow;
color backgroundColor = lightBackgroundColor;


Gumb eraserButton = new Gumb("eraser");
Gumb sprayButton = new Gumb("spray");
Gumb fillBucket = new Gumb("fillBucket");
Gumb photo = new Gumb("photo");

Grid toolGrid = new Grid(3, 2);
Gumb[] toolButtons= { eraserButton, sprayButton, fillBucket, photo};
Grid colorGrid = new Grid(2, 14); // [2][14]
Gumb[] colorButtons = { new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple),
  new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple),
  new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple),
  new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple),
  new Gumb(30, 30, 30, 30, yellow), new Gumb(30, 30, 30, 30, red), new Gumb(30, 30, 30, 30, marine), new Gumb(30, 30, 30, 30, purple)};

////image import, export
Grid importExportGrid = new Grid(1, 2);
Gumb importButton = new Gumb("Import");
Gumb exportButton = new Gumb("Export");
Gumb[] importExportArray = {importButton, exportButton};
PImage loadedImage, resizedImportedImage;
float resizedImageScale;
boolean importSelected = false;
boolean exportSelected = false;

// .svg slike 
Grid photoGrid = new Grid(2, 2);
Gumb houseButton = new Gumb("House");
Gumb carButton = new Gumb("Car");
Gumb butterflyButton = new Gumb("Butterfly");
Gumb catButton = new Gumb("Cat");
Gumb[] PhotoArray = {houseButton, carButton, butterflyButton,catButton };
PShape house;
PShape car;
PShape butterfly;
PShape cat;
boolean photoSelected = false; 
boolean houseSelected = false;
boolean carSelected = false;
boolean butterflySelected=false;
boolean catSelected=false;

Gumb firstChosenColorButton = new Gumb(0, 595, purple);
Gumb secondChosenColorButton = new Gumb(0, 645, yellow);
PImage pooImage;
PGraphics generatedImage;
int prevMouseX, prevMouseY;



void setup() {
  background(backgroundColor);
  size(1050, 750);
  fill(white);
  rect(105, 100, 750, 450); // canvas - white space for drawing

  toolGrid.addButtons(toolButtons, 0, 0, 50, 50);
  colorGrid.addButtons(colorButtons, 50, 605, 30, 30);
  importExportGrid.addButtons(importExportArray, 900, 0, 50, 50);
  photoGrid.addButtons(PhotoArray,900, 100, 50, 50 );
  
  cp5 = new ControlP5(this);
  font = loadFont("Hiragino15.vlw");

  spray = loadImage("spray.png");
 
  
  generatedImage = createGraphics(750, 450);
  //setupSaveImageTextfield();
  
  house=loadShape("kuca.svg");
  car=loadShape("car.svg");
  butterfly=loadShape("butterfly.svg");
  cat=loadShape("cat.svg");
}

void draw() {
  background(backgroundColor);
  drawBackground();
  toolGrid.drawGrid();
  colorGrid.drawGrid();
  importExportGrid.drawGrid();
 
 

  firstChosenColorButton.nacrtajGumb();
  secondChosenColorButton.nacrtajGumb();
  
  eraserButton.prikaziSliku("candy.png");

   //image(spray, mouseX, mouseY, 50, 50);
  
  if(importedImagesArray != null){
    //image(resizedImportedImage, 105, 100);
    for (Image image : importedImagesArray) {
      image.draw();
    }
  }
  drawSprayCanPreview(mouseX, mouseY);
  if (mousePressed){ // && sprayButton.isSelected){
    if(sprayButton.isSelected){
       
      // drag and drop 
      //line(prevMouseX, prevMouseY, mouseX, mouseY);
      drawSprayCircle( mouseX, mouseY, 20, 20); // prevMouseX, prevMouseY, 20-50 slider
      //PImage spray = loadImage("spray.png");
  
  
      
      //PImage
      //generatedImage = get(105, 100, 750, 450);
      //image(generatedImage, 105, 100, 750, 450);
  
      //generatedImage.save("nesto" + ".png");  // + numGenImages
      //numGenImages++;
      //image(spray, mouseX, mouseY, 50, 50);
    }
    
  }

  if (generatedImage != null) {
    image(generatedImage, 105, 100);
  }
  //image(pooImage, 200, 100);
  prevMouseX = mouseX;
  prevMouseY = mouseY;
  
  if(photoSelected)
  {
     photoGrid.drawGrid();
  }
  if( (mousePressed && houseButton.unutar()) || houseSelected){
    houseSelected=true; 
    shape(house, 110, -100);
    
    }
  if( (mousePressed && carButton.unutar()) || carSelected){
    carSelected=true; 
    shape(car, 50, -250);
  }
  if( (mousePressed && butterflyButton.unutar()) || butterflySelected){
    butterflySelected=true; 
    shape(butterfly, -350, -500);
  }
  if( (mousePressed && catButton.unutar()) || catSelected){
    catSelected=true; 
    shape(cat, -100, -100);
  }
}

void mouseClicked() {
  Gumb pressedToolButton = toolGrid.returnPressedButton();
  if (pressedToolButton != null) {
    print("image name: " + pressedToolButton.imageName + "\n");
    isSaveVisible = false;
  }

  Gumb chosenColorButton = colorGrid.returnPressedButton();
  if (chosenColorButton != null) {
    print("position: " + chosenColorButton.x + " " + chosenColorButton.y + "\n");
  }

  if (exportButton.unutar()) {
    exportSelected = true;
    selectOutput("Select a file to process:", "fileSelected");
  }
  if (importButton.unutar()) {
    // draw slider, cut image, "drag and drop"
    isSaveVisible = true;
    importSelected = true;
    selectInput("Select a file to process:", "fileSelected");
  }
  
  if (sprayButton.unutar()) {
    sprayButton.isSelected = true;
    //deselectOtherToolButtonsExcept();
  }

  if (fillBucket.unutar()) {
    backgroundColor = yellow; // selected background - anton
  }
//  if (insideCanvas()) {
//    //PImage spray = loadImage("spray.png");

//    image(spray, mouseX, mouseY);

//    //PImage
//    generatedImage = get(105, 100, 750, 450);
//    //image(generatedImage, 105, 100, 750, 450);

//    //generatedImage.save("nesto" + numGenImages + ".png");
//    //numGenImages++;
//    image(spray, mouseX, mouseY, 5, 5);
//  }

//  image(generatedImage, 105, 100, 750, 450);

  if(photo.unutar()){
   photoSelected=true;
  }
  
}




void keyPressed() {
  // h - help
  // s - save
  if (key == 's' || key == 'S') {
    isSaveVisible = true;
    selectInput("Select a file to process:", "fileSelected");
  }
  //if (key == 'p' || key == 'P') {
  //  PImage spray = loadImage("spray.png");

  //  image(spray, mouseX, mouseY);

  //  PImage generatedImage = get(105, 100, 750, 450);
  //  generatedImage.save("nesto" + numGenImages + ".png");
  //  numGenImages++;
  //}
  
}

void setupSaveImageTextfield() {
  generatedImageTextfield = cp5.addTextfield("imageName")
    .setPosition(550, 620)
    .setSize(250, 70)
    .setVisible(false)
    .setColor(color(255, 255, 204))
    .setColorActive(color(255, 255, 204))
    .setColorForeground(color(255))
    .setColorBackground(color(0))
    .setFont(font)
    .setText("screen"); // placeholder

  // hide caption label
  generatedImageTextfield.getCaptionLabel().setText("");
}

void fileSelected(File selection) {
  if(selection != null) {
    if (importSelected) {
  
      println("import -User selected " + selection.getAbsolutePath());
      loadedImage = loadImage(selection.getAbsolutePath()); // user image does not need to be inside data folder
  
      float widthRatio = 750 / loadedImage.width;
      float heightRatio = 450 / loadedImage.height;
      resizedImageScale = min(widthRatio, heightRatio);
  
      int resizedImageWidth = int(loadedImage.width * resizedImageScale);
      int resizedImageHeight = int(loadedImage.height * resizedImageScale);
  
      resizedImportedImage = loadedImage.copy();
      resizedImportedImage.resize(resizedImageWidth, resizedImageHeight);
      
  
      image(resizedImportedImage, 105, 100);
      Image img = new Image(resizedImportedImage, 105, 100);
      importedImagesArray.add(img);
  
      importSelected = false;
    } else if (exportSelected) {
      PImage generatedImage = get(105, 100, 750, 450); // screenshot of canvas
  
      String filePath = selection.getAbsolutePath();
      String filePathLowerCase = filePath.toLowerCase();
      if (!filePathLowerCase.endsWith(".png") && !filePathLowerCase.endsWith(".jpg") && !filePathLowerCase.endsWith(".jpeg")) {
        filePath += ".png"; // default save as png, if not provided, image is not saved, could add gif (gifAnimation library) as part of future improvements
      }
  
      generatedImage.save(filePath);
      println("export - User selected: " + filePath);
      exportSelected = false;
    }
  }
}

boolean insideCanvas() { //105, 100, 750, 450
  if ( mouseX >= 105 && mouseX <= 855
    && mouseY >= 100 && mouseY <= 550) {
    return true;
  }
  return false;
}

void drawBackground(){
  fill(200);
  noStroke();
  rect(0,0, 1050, 101);
  rect(0, 0, 106,751);
  rect(856, 100, 300, 750);
  rect(105, 550, 751, 750);
  stroke(5);
}

void deselectOtherToolButtonsExcept(){
  for (int i = 0; i < toolGrid.row; i++){
    for (int j = 0; j < toolGrid.col; j++){
      if (toolGrid.buttons[i][j] != null){
        toolGrid.buttons[i][j].isSelected = false;
      }
    }
  }
}
