// 2D Array of objects
Cell[][] grid;

// Number of columns and rows in the grid
int cols = 20;
int rows = 20;

void setup() {
  size(800,500);
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*20,j*20,20,20);
    }
  }
  fill(color(150));
}

void draw() {
  background(0);
  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Display each object
      grid[i][j].display();
    }
  }
}

// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
  }
  
  //helper methods used to get values of squares
  float getX(){
   return x; 
  }
  float getY(){
   return y; 
  }
  float getW(){
   return w; 
  }
  float getH(){
   return h; 
  }
  
  void display() {
    stroke(255);
    rect(x,y,w,h); 
  }
}


void mousePressed(){
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if(mouseX >= grid[i][j].getX() && mouseY >= grid[i][j].getY() && 
      mouseX <= grid[i][j].getX()+grid[i][j].getW() && mouseY<=grid[i][j].getY()+grid[i][j].getH()){
        fill(color(255,0,0));
      }
    }
  }
}
