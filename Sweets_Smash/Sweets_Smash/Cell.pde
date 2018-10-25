// A Cell object
class Cell {
  // A cell object knows about its location in the grid 
  // as well as its size with the variables x,y,w,h
  float x,y;   // x,y location
  float w,h;   // width and height
  color c;    // color of each square
  boolean picked = false;

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH,color tempC) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    c = tempC;
  }
  
  //create red border around selected cell
  void display() {
    if(picked){
      stroke(0);
    }else{
      stroke(255);
    }
    strokeWeight(3);
    fill(c);
    rect(x,y,w,h); 
  }
}
