// 2D Array of objects
Cell[][] grid;

//Keep track of last picked Cell
int lastpickedRow;
int lastpickedCol;
boolean lastpicked = false;

//Colors for candy in board
color red = color(255,0,0);
color blue = color(0,0,255);
color orange = color(255,165,0);
color purple = color(255,0,255);
color green = color(0,255,0);
color black = color(0);


// Number of columns and rows in the grid
int cols = 9;
int rows = 9;

void setup() {
  size(500,500);
  
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*50+25,j*50+25,50,50,getRandomColor());
      while(checkThreeInARow(i,j)){
        grid[i][j].c = getRandomColor(); 
      }
    }
  }
}

void draw() {
  background(255);
  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
  //translate(25,25);
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Display each object
      grid[i][j].display();
    }
  }
  boolean check3 = checkThreeInARow();
}


//Swap adjacent selected squares
void swapColor(int i1, int j1, int i2, int j2){
   if((i1==i2 && (j1-1==j2 || j1+1==j2))  || (i1+1==i2 && j1==j2)|| (i1-1==i2 && j1==j2)){
     color col = grid[i2][j2].c;
     grid[i2][j2].c= grid[i1][j1].c;
     grid[i1][j1].c = col;
   }
}



void mousePressed(){
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //check if mouse is pressed and inside a square
      if(mouseX >= grid[i][j].x && mouseY >= grid[i][j].y && 
      mouseX <= grid[i][j].x+grid[i][j].w && mouseY<=grid[i][j].y+grid[i][j].h){
        //if square has been selected already, swap with newly selected square
        if(lastpicked==true){
          swapColor(i,j,lastpickedRow,lastpickedCol);
          lastpicked=false;
        }else{
          lastpickedRow = i;
          lastpickedCol = j;
          lastpicked = true;
        }  
      }
    }
  }
}

//generate and return random color for each cell in grid
color getRandomColor(){
  int num = (int) random(5);
  color col = 0;
  switch(num){
    case 0: col = red; break;
    case 1: col = green; break;
    case 2: col = purple; break;
    case 3: col = blue; break;
    case 4: col = orange; break;
  }
  return col;
}

//add function to get rid of tiles that are 3 in a row
boolean checkThreeInARow(){
  boolean result = false;
  
  
  for (int i = 0; i < cols-2; i++) {
    for (int j = 0; j < rows-2; j++) {
      if(grid[i][j] !=null && grid[i+1][j] != null && grid[i+2][j] !=null){
        if(grid[i][j].c == grid[i+1][j].c && grid[i+1][j].c == grid[i+2][j].c){
          grid[i][j].c = black;
          grid[i+1][j].c = black;
          grid[i+2][j].c = black;
          result = true;
        }
      }
      
      
    }
  }
  
  return result;
}

boolean checkThreeInARow(int i, int j){
  boolean result = false;
  if(i<7 && j<7 && grid[i][j] !=null && grid[i+1][j] != null && grid[i+2][j] !=null){
    if(grid[i][j].c == grid[i+1][j].c && grid[i+1][j].c == grid[i+2][j].c){
      grid[i][j].c = black;
      grid[i+1][j].c = black;
      grid[i+2][j].c = black;
      result = true;
    }
  }
  return result;
}
