class Grid {
    Gumb[][] buttons;
    int row, col;
    
    Grid(int row, int col) {
      this.row = row;
      this.col = col;
      buttons = new Gumb[row][col];  
    }
    
    void addButton(Gumb button, int row, int col) {
      buttons[row][col] = button;
    }
    
    // w i h could be calculated from ie first button in given array
    void addButtons(Gumb[] setupButtons, float startX, float startY, float w, float h) {
      int index = 0;
      for(int i = 0; i < row; i++) {
        for(int j = 0; j < col; j++) {
          if (index < setupButtons.length){
            setupButtons[index].postaviPoziciju(startX + j * w, startY + i * h);
            buttons[i][j] = setupButtons[index++];
          }
        }
      }
    }
    
    Gumb returnPressedButton( ){
      for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
          if (buttons[i][j] != null && buttons[i][j].unutar() ){
            return buttons[i][j];
          }
        }
      }
      return null;
    }
    
    void drawGrid() {
      for (int i = 0; i < row; i++) {
        for (int j = 0; j < col; j++) {
          Gumb button = buttons[i][j];
          if (button != null){
            button.nacrtajGumb();
            if (button.imageName != "") {
              button.nacrtajSliku();
            }
          }
        }
      }
   }
}
