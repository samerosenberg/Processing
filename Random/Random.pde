  
// Click within the image to change 
// the value of the rectangle after
// after the mouse has been clicked

int value = 0;

void draw() {
  fill(value);
  rect(25, 25, 50, 50);
}

void mouseClicked() {
  if (value == 0 & mouseX>=25 & mouseX<=75 & mouseY>=25 & mouseY<=75) {
    value = 255;
  } else {
    value = 0;
  }
}
