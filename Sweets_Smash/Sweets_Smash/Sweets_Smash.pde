//once match is made, move squares above down
//make it so swap only works if match will be made - make a canSwap method
//add check for no three in a rows


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
color white = color(255);


// Number of columns and rows in the grid
int cols = 9;
int rows = 9;

void setup() {
  size(500,500);
  //fullScreen();
  
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*50+(width/2)-225,j*50+(height/2)-225,50,50,getRandomColor());
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
  checkThreeInARow();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Display each object
      grid[i][j].display();
    }
  }
  if(lastpicked){
   grid[lastpickedRow][lastpickedCol].display(); 
  }
}


//Swap adjacent selected squares
void swapColor(int i1, int j1, int i2, int j2){
   if((i1==i2 && (j1-1==j2 || j1+1==j2))  || (i1+1==i2 && j1==j2)|| (i1-1==i2 && j1==j2)){
     color col = grid[i2][j2].c;
     grid[i2][j2].c= grid[i1][j1].c;
     grid[i1][j1].c = col;
   }
}

boolean canSwap(int i1, int j1, int i2, int j2){
  boolean result = true;
  swapColor(i1,j1,i2,j2);
  if(!checkThreeInARow()){
    swapColor(i1,j1,i2,j2);
    result = false;
  }
  return result;
}



void mousePressed(){
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      //check if mouse is pressed and inside a square
      if(mouseX >= grid[i][j].x && mouseY >= grid[i][j].y && 
      mouseX <= grid[i][j].x+grid[i][j].w && mouseY<=grid[i][j].y+grid[i][j].h){
        //if square has been selected already, swap with newly selected square
        if(lastpicked==true){
          canSwap(i,j,lastpickedRow,lastpickedCol);
          grid[lastpickedRow][lastpickedCol].picked = false;
          lastpicked=false;
        }else{
          grid[i][j].picked = true;
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
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
      //check if three in a row to the right
      if(i+2<grid.length){
        if(grid[i][j].c == grid[i+1][j].c && grid[i+1][j].c == grid[i+2][j].c){
          if(checkFourInARow(i,j,1)){
            if(checkFiveInARow(i,j,1)){
              grid[i+4][j].c=white;
            }
            grid[i+3][j].c=white;
          }
           grid[i][j].c = white;
          grid[i+1][j].c = white;
          grid[i+2][j].c = white;
          result = true;
        }
      }
      
      //check if three in a row downwards
      if(j+2<grid.length){
        if(grid[i][j].c == grid[i][j+1].c && grid[i][j+1].c == grid[i][j+2].c){
          if(checkFourInARow(i,j,2)){
            if(checkFiveInARow(i,j,2)){
              grid[i][j+4].c=white;
            }
            grid[i][j+3].c=white;
          }
          grid[i][j].c = white;
          grid[i][j+1].c = white;
          grid[i][j+2].c = white;
          result = true;
        }
      }
    }
  }
  
  return result;
}

boolean checkThreeInARow(int i, int j){
  boolean result = false;
  //check if three in a row to the right
  if(i+2<grid.length && grid[i+1][j]!=null && grid[i+2][j]!=null){
    if(grid[i][j].c == grid[i+1][j].c && grid[i+1][j].c == grid[i+2][j].c){
        result = true;
      }
    }
    //check if three in a row downwards
    if(j+2<grid.length && grid[i][j+1]!=null && grid[i][j+2]!=null){
      if(grid[i][j].c == grid[i][j+1].c && grid[i][j+1].c == grid[i][j+2].c){
        result = true;
      }
    }
    //check if three in a row to the left
    if(i-2>=0 && grid[i-1][j]!=null && grid[i-2][j]!=null){
      if(grid[i][j].c == grid[i-1][j].c && grid[i-1][j].c == grid[i-2][j].c){
        result = true;
      }
    }
    //check if three in a row up
    if(j-2>=0 && grid[i][j-1]!=null && grid[i][j-2]!=null){
      if(grid[i][j].c == grid[i][j-1].c && grid[i][j-1].c == grid[i][j-2].c){
        result = true;
      }
    }

  return result;
}

boolean checkFourInARow(int i, int j, int dir){
  boolean result = false;
  
   //check if four in a row to the right
   if(dir == 1){
    if(i+3<grid.length && grid[i+3][j]!=null){
      if(grid[i][j].c == grid[i+3][j].c){
          result = true;
        }
      }
   }
   //check if four in a row downwards
   if(dir==2){
      if(j+3<grid.length && grid[i][j+3]!=null){
        if(grid[i][j].c == grid[i][j+3].c){
          result = true;
        }
      }
   }
  
  return result;
}

boolean checkFiveInARow(int i, int j, int dir){
  boolean result = false;
  
   //check if five in a row to the right
   if(dir == 1){
    if(i+4<grid.length && grid[i+4][j]!=null){
      if(grid[i][j].c == grid[i+4][j].c){
          result = true;
        }
      }
   }
   //check if five in a row downwards
   if(dir==2){
      if(j+4<grid.length && grid[i][j+4]!=null){
        if(grid[i][j].c == grid[i][j+4].c){
          result = true;
        }
      }
   }  
 
  return result;
}
